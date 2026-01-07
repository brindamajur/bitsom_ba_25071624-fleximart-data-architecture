FlexiMart Relational Database Schema Documentation
1. Entity–Relationship Description (Text Format)
    ENTITY: customers

        Purpose: Stores personal and contact details of registered customers.

        Attributes:

            customer_id – Primary Key, auto-increment surrogate key

            first_name – Customer’s first name

            last_name – Customer’s last name

            email – Unique email ID for login/communication

            phone – Standardized contact number (e.g., +91-9876543210)

            city – City of residence

            registration_date – Date of registration on FlexiMart platform

        Relationships:

            1 : M relationship with orders

            One customer can place many orders

            Each order belongs to exactly one customer

    ENTITY: products

        Purpose: Stores information about items sold on FlexiMart.

        Attributes:

            product_id – Primary Key, auto-increment surrogate key

            product_name – Name of the product

            category – Product category (e.g., Electronics, Fashion, Groceries)

            price – Selling price per unit

            stock_quantity – Available inventory units

        Relationships:

            1 : M relationship with order_items

            One product can appear in many order line items

            Each order item refers to exactly one product

    ENTITY: orders

        Purpose: Represents customer orders placed on the platform.

        Attributes:

            order_id – Primary Key, auto-increment

            customer_id – Foreign Key referencing customers(customer_id)

            order_date – Date on which the order was placed

            total_amount – Total value of order

            status – Order status (Pending, Completed, Cancelled etc.)

        Relationships:

            M : 1 with customers

            1 : M with order_items

    ENTITY: order_items

        Purpose: Stores line-level details for each order (products within order).

        Attributes:

            order_item_id – Primary Key

            order_id – Foreign Key referencing orders(order_id)

            product_id – Foreign Key referencing products(product_id)

            quantity – Units of product ordered

            unit_price – Price per unit at time of purchase

            subtotal – quantity × unit_price

        Relationships:

            M : 1 with orders

            M : 1 with products

2. Normalization and 3NF Explanation 

    The FlexiMart database is designed in Third Normal Form (3NF) to minimize redundancy and avoid anomalies.

    In the customers table, non-key attributes such as name, email, phone, city and registration_date depend directly on the primary key customer_id. There are no repeating groups and no partial dependencies because no composite key exists.

    In the products table, all attributes such as product_name, category, price and stock_quantity depend only on the primary key product_id, satisfying 2NF and 3NF conditions.

    The orders table contains order-level data, where order_id is the primary key. Non-key attributes such as order_date, total_amount and status depend only on order_id, while customer_id is a foreign key linking customers without embedding duplicate customer details.

    The order_items table ensures that details of multiple products per order are stored without repetition. Each row uniquely identifies an item within an order using order_item_id. Attributes quantity, unit_price, and subtotal depend only on this primary key.

    This design prevents:

        Update anomaly: Customer information is stored in one place only

         anomaly: A new product can be added without needing an order

        Delete anomaly: Deleting an order does not remove product or customer records

    By separating entities into logical tables and linking them using foreign keys, the database satisfies 1NF, 2NF, and 3NF, resulting in a well-structured relational schema with integrity and minimal redundancy.

3. Sample Data Representation
    customers
    --------------------------------------------------------------------
    | customer_id |	first_name |	last_name |	email                  |
    --------------------------------------------------------------------
    |   1	      |	Rahul	   | Sharma       |rahul.sharma@gmail.com  |
    |-------------------------------------------------------------------
    |   2	      | Priya	   | Patel	      |priya.patel@yahoo.com   |
    --------------------------------------------------------------------
products
    -----------------------------------------------------------------------
    | product_id |	product_name           |	category       |	price |
    -----------------------------------------------------------------------
    |   1	      |	Samsung Galaxy S21     | Electronics       |45999.00  |
    |----------------------------------------------------------------------
    |   2	      | Nike Running Shoes	   | Fashion	       |3499.00   |
    -----------------------------------------------------------------------	 		
orders
    ------------------------------------------------------------------
    | order_id |	customer_id  |	order_date       |	total_amount |
    ------------------------------------------------------------------
    |   101	   |	1            | 2024-01-15        |   45999.00    |
    |-----------------------------------------------------------------
    |   102	   |    2	         | 2024-01-16	     |35998.00       |
    ------------------------------------------------------------------	 
order_items
    ----------------------------------------------------------------------------
    | order_item_id |	order_id  |	ordeproduct_id  |	quantity |  subtotal   |
    ----------------------------------------------------------------------------
    |   1	        |	101       | 1               |      1     |  45999.00   |
    |---------------------------------------------------------------------------
    |   2           |    102	  | 2	            |      2     |   5998.00   |
    ----------------------------------------------------------------------------	
				