import pandas as pd
import mysql.connector
from datetime import datetime
import re

# ------------------ DB CONNECTION ------------------

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Brinda16@",   
    database="fleximart"
)
cursor = conn.cursor()

print("Connected to MySQL")

# ------------------ HELPERS ------------------

def clean_date(x):
    if pd.isna(x):
        return None
    fmts = ["%Y-%m-%d", "%d/%m/%Y", "%d-%m-%Y", "%m-%d-%Y", "%m/%d/%Y"]
    for f in fmts:
        try:
            return datetime.strptime(str(x), f).strftime("%Y-%m-%d")
        except:
            pass
    return None

def clean_phone(x):
    if pd.isna(x):
        return None
    d = re.sub(r'\D', "", str(x))[-10:]
    if len(d) == 10:
        return f"+91-{d}"
    return None

# ------------------ EXTRACT ------------------

customers = pd.read_csv("data/customers_raw.csv")
products = pd.read_csv("data/products_raw.csv")
sales = pd.read_csv("data/sales_raw.csv")

# ---------------------------------------------
# COUNTERS FOR REPORT
# ---------------------------------------------

# records processed
customers_before = len(customers)
products_before = len(products)
sales_before = len(sales)

# duplicate counters
customer_dup_removed = customers.duplicated().sum()
product_dup_removed = products.duplicated().sum()
sales_dup_removed = sales.duplicated().sum()

# missing values counters
missing_customer_emails = customers["email"].isna().sum()
missing_product_prices = products["price"].isna().sum()
missing_sales_fk = sales["customer_id"].isna().sum() + sales["product_id"].isna().sum()

# ------------------ TRANSFORM ------------------

# ===== CUSTOMERS =====
customers = customers.drop_duplicates()
customers = customers[customers["email"].notna()]  # remove missing emails
customers["phone"] = customers["phone"].apply(clean_phone)
customers["registration_date"] = customers["registration_date"].apply(clean_date)
customers["city"] = customers["city"].str.title()

# ===== PRODUCTS =====
products = products.drop_duplicates()

products["product_name"] = (
    products["product_name"]
    .str.replace(r"\s+", " ", regex=True)
    .str.strip()
)

products["category"] = products["category"].str.lower().replace({
    "electronics": "Electronics",
    "fashion": "Fashion",
    "groceries": "Groceries"
})

products = products[products["price"].notna()]
products["stock_quantity"] = products["stock_quantity"].fillna(0)

# ===== SALES =====
sales = sales.drop_duplicates()

sales = sales.dropna(subset=["customer_id", "product_id"])
sales = sales[sales["status"] != "Cancelled"]
sales["transaction_date"] = sales["transaction_date"].apply(clean_date)
sales["subtotal"] = sales["quantity"] * sales["unit_price"]

print("Data cleaned")

# ------------------ LOAD ------------------

customer_code_to_dbid = {}

for _, r in customers.iterrows():
    cursor.execute("""
        INSERT IGNORE INTO customers(first_name,last_name,email,phone,city,registration_date)
        VALUES (%s,%s,%s,%s,%s,%s)
    """, (
        r["first_name"],
        r["last_name"],
        r["email"],
        r["phone"],
        r["city"],
        r["registration_date"]
    ))

    new_id = cursor.lastrowid

    if new_id == 0:
        cursor.execute("SELECT customer_id FROM customers WHERE email=%s", (r["email"],))
        new_id = cursor.fetchone()[0]

    customer_code_to_dbid[r["customer_id"]] = new_id

conn.commit()

product_code_to_dbid = {}

for _, r in products.iterrows():
    cursor.execute("""
        INSERT INTO products(product_name,category,price,stock_quantity)
        VALUES (%s,%s,%s,%s)
    """, (
        r["product_name"],
        r["category"],
        r["price"],
        int(r["stock_quantity"])
    ))

    product_code_to_dbid[r["product_id"]] = cursor.lastrowid

conn.commit()

valid_customer_codes = set(customer_code_to_dbid.keys())
valid_product_codes = set(product_code_to_dbid.keys())

sales = sales[sales["customer_id"].isin(valid_customer_codes)]
sales = sales[sales["product_id"].isin(valid_product_codes)]

unique_tx = sales["transaction_id"].unique()

orders_loaded = 0
order_items_loaded = 0

for tx in unique_tx:

    tx_rows = sales[sales["transaction_id"] == tx]

    cust_code = tx_rows.iloc[0]["customer_id"]
    customer_db_id = customer_code_to_dbid.get(cust_code)

    if customer_db_id is None:
        continue

    order_date = tx_rows.iloc[0]["transaction_date"]
    status = tx_rows.iloc[0]["status"]
    total_amount = tx_rows["subtotal"].sum()

    cursor.execute("""
        INSERT INTO orders(customer_id, order_date, total_amount, status)
        VALUES (%s,%s,%s,%s)
    """, (int(customer_db_id), order_date, total_amount, status))

    order_id = cursor.lastrowid
    orders_loaded += 1

    for _, r in tx_rows.iterrows():

        prod_code = r["product_id"]
        product_db_id = product_code_to_dbid.get(prod_code)

        if product_db_id is None:
            continue

        cursor.execute("""
            INSERT INTO order_items(order_id, product_id, quantity, unit_price, subtotal)
            VALUES (%s,%s,%s,%s,%s)
        """, (
            order_id,
            int(product_db_id),
            int(r["quantity"]),
            r["unit_price"],
            r["subtotal"]
        ))

        order_items_loaded += 1

conn.commit()

# ------------------ DATA QUALITY REPORT ------------------

with open("part1-database-etl/data_quality_report.txt", "w") as f:

    f.write("FlexiMart Data Quality Report\n")
    f.write("---------------------------------\n\n")

    # 1 -----------------------------
    f.write("Number of records processed per file:\n")
    f.write(f"  Customers processed: {customers_before}\n")
    f.write(f"  Products processed: {products_before}\n")
    f.write(f"  Sales processed: {sales_before}\n\n")

    # 2 -----------------------------
    f.write("Number of duplicates removed:\n")
    f.write(f"  Customer duplicates removed: {customer_dup_removed}\n")
    f.write(f"  Product duplicates removed: {product_dup_removed}\n")
    f.write(f"  Sales duplicates removed: {sales_dup_removed}\n\n")

    # 3 -----------------------------
    f.write("Number of missing values handled:\n")
    f.write(f"  Missing customer emails removed: {missing_customer_emails}\n")
    f.write(f"  Missing product prices removed: {missing_product_prices}\n")
    f.write(f"  Missing sales FK rows removed: {missing_sales_fk}\n\n")

    # 4 -----------------------------
    f.write("Number of records loaded successfully:\n")
    f.write(f"  Customers loaded: {len(customers)}\n")
    f.write(f"  Products loaded: {len(products)}\n")
    f.write(f"  Orders loaded: {orders_loaded}\n")
    f.write(f"  Order items loaded: {order_items_loaded}\n")

cursor.close()
conn.close()

print("ETL completed successfully and report generated.")
