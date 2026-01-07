USE fleximart_dw;

-------------------------------
-- DIM DATE (30 dates)
-------------------------------

INSERT INTO dim_date(date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, 0),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, 0),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, 0),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, 1),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, 1),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, 0),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, 0),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, 1),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, 0),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, 1),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, 1),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, 0),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, 1),
(20240201, '2024-02-01', 'Thursday', 1, 2, 'February', 'Q1', 2024, 0),
(20240202, '2024-02-02', 'Friday', 2, 2, 'February', 'Q1', 2024, 0),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, 1),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, 1),
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, 0),
(20240207, '2024-02-07', 'Wednesday', 7, 2, 'February', 'Q1', 2024, 0),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, 1),
(20240211, '2024-02-11', 'Sunday', 11, 2, 'February', 'Q1', 2024, 1),
(20240212, '2024-02-12', 'Monday', 12, 2, 'February', 'Q1', 2024, 0),
(20240214, '2024-02-14', 'Wednesday', 14, 2, 'February', 'Q1', 2024, 0),
(20240215, '2024-02-15', 'Thursday', 15, 2, 'February', 'Q1', 2024, 0),
(20240217, '2024-02-17', 'Saturday', 17, 2, 'February', 'Q1', 2024, 1),
(20240218, '2024-02-18', 'Sunday', 18, 2, 'February', 'Q1', 2024, 1),
(20240220, '2024-02-20', 'Tuesday', 20, 2, 'February', 'Q1', 2024, 0),
(20240222, '2024-02-22', 'Thursday', 22, 2, 'February', 'Q1', 2024, 0),
(20240224, '2024-02-24', 'Saturday', 24, 2, 'February', 'Q1', 2024, 1),
(20240225, '2024-02-25', 'Sunday', 25, 2, 'February', 'Q1', 2024, 1);

-------------------------------
-- DIM PRODUCT (15 products)
-------------------------------

INSERT INTO dim_product(product_id, product_name, category, subcategory, unit_price) VALUES
('ELEC001','Samsung Galaxy S23','Electronics','Smartphone',74999.00),
('ELEC002','iPhone 15','Electronics','Smartphone',82999.00),
('ELEC003','Dell Inspiron Laptop','Electronics','Laptop',58999.00),
('ELEC004','Sony Headphones','Electronics','Audio',7999.00),
('ELEC005','LG 55 inch Smart TV','Electronics','Television',65999.00),

('GROC001','Basmati Rice 5kg','Groceries','Food Grains',699.00),
('GROC002','Fortune Sunflower Oil 1L','Groceries','Edible Oil',165.00),
('GROC003','Tata Salt 1kg','Groceries','Essentials',28.00),
('GROC004','Amul Butter 500g','Groceries','Dairy',260.00),
('GROC005','Maggi Noodles 12 Pack','Groceries','Instant Food',180.00),

('FASH001','Levis Jeans','Fashion','Clothing',3499.00),
('FASH002','Nike Running Shoes','Fashion','Footwear',5999.00),
('FASH003','Allen Solly Shirt','Fashion','Clothing',2499.00),
('FASH004','Adidas T-shirt','Fashion','Clothing',1599.00),
('FASH005','Puma Track Pants','Fashion','Clothing',1999.00);

-------------------------------
-- DIM CUSTOMER (12 customers)
-------------------------------

INSERT INTO dim_customer(customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Mumbai','Maharashtra','Regular'),
('C002','Priya Patel','Ahmedabad','Gujarat','Premium'),
('C003','Amit Kumar','Delhi','Delhi','Regular'),
('C004','Sneha Reddy','Hyderabad','Telangana','Premium'),
('C005','Vikram Singh','Bengaluru','Karnataka','Gold'),
('C006','Neha Verma','Pune','Maharashtra','Regular'),
('C007','Ravi Nair','Kochi','Kerala','Regular'),
('C008','Kavya Menon','Chennai','Tamil Nadu','Gold'),
('C009','Arjun Mehta','Surat','Gujarat','Premium'),
('C010','Swati Desai','Vadodara','Gujarat','Regular'),
('C011','Manish Joshi','Jaipur','Rajasthan','Regular'),
('C012','Deepa Kapoor','Delhi','Delhi','Premium');

-------------------------------
-- FACT SALES (40 rows)
-- Weekend = higher quantity
-------------------------------

INSERT INTO fact_sales(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240106,1,1,2,74999,0,149998),
(20240107,2,2,1,82999,0,82999),
(20240110,4,3,3,7999,500,22997),
(20240112,3,4,1,58999,0,58999),
(20240113,5,5,2,65999,0,131998),

(20240115,6,6,5,699,0,3495),
(20240120,7,7,4,165,0,660),
(20240121,8,8,6,28,0,168),
(20240125,9,9,3,260,0,780),
(20240128,10,10,10,180,200,1600),

(20240201,11,11,2,3499,0,6998),
(20240202,12,12,1,5999,0,5999),
(20240203,13,1,3,2499,200,7297),
(20240204,14,2,4,1599,100,6296),
(20240205,15,3,2,1999,0,3998),

(20240207,1,4,1,74999,0,74999),
(20240210,2,5,2,82999,2000,163998),
(20240211,3,6,1,58999,0,58999),
(20240212,4,7,2,7999,0,15998),
(20240214,5,8,1,65999,0,65999),

(20240215,6,9,3,699,0,2097),
(20240217,7,10,4,165,0,660),
(20240218,8,11,5,28,0,140),
(20240220,9,12,2,260,0,520),
(20240222,10,1,8,180,0,1440),

(20240224,11,2,2,3499,0,6998),
(20240225,12,3,3,5999,0,17997),
(20240103,13,4,1,2499,0,2499),
(20240105,14,5,2,1599,0,3198),
(20240106,15,6,4,1999,0,7996),

(20240107,1,7,1,74999,0,74999),
(20240110,2,8,1,82999,0,82999),
(20240112,3,9,1,58999,0,58999),
(20240113,4,10,2,7999,0,15998),
(20240115,5,11,1,65999,0,65999),

(20240120,6,12,4,699,0,2796),
(20240121,7,1,5,165,0,825),
(20240125,8,2,6,28,0,168),
(20240128,9,3,3,260,0,780),
(20240201,10,4,10,180,0,1800);
