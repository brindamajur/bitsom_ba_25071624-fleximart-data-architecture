Section A: Limitations of RDBMS for Product Catalog (≈150 words)

The current relational database works well for structured and uniform data, but it struggles when product attributes vary widely. For example, laptops have features like RAM, storage, processor, and screen size, while shoes have size, color, and material. In a relational model, this would require either many NULL columns, a very wide table, or multiple child tables, all of which make queries complex and inefficient.

Frequent schema changes are also difficult in RDBMS. When new product types are added, the DBA must alter table structures, migrate data, and update application logic. This reduces agility and increases downtime risk.

Storing customer reviews is another limitation. Reviews naturally belong as nested lists inside a product, but relational systems force reviews into a separate table with foreign keys. This results in many joins, reducing performance and making queries less intuitive. Therefore, relational databases become rigid and complex for highly variable product catalogs.

Section B: Why MongoDB is Suitable (≈150 words)

MongoDB is a document-oriented NoSQL database that stores data in flexible JSON-like documents. Each product can have its own structure, meaning laptops, shoes, furniture, and groceries can all store different attribute sets without NULL values or schema changes. New attributes can simply be added to documents rather than altering tables.

Customer reviews can be stored as embedded arrays directly within the product document. This allows product details and reviews to be retrieved in a single query without joins, which improves read performance and simplifies the application layer.

MongoDB also supports horizontal scalability through sharding. As FlexiMart’s catalog and traffic grow, data can be distributed across multiple servers while remaining accessible as one logical database. This makes MongoDB well suited for large-scale e-commerce platforms with high read/write loads, evolving product structures, and rapidly changing business needs.

Section C: Trade-offs of Using MongoDB (≈100 words)

Despite its advantages, MongoDB does have trade-offs. First, it does not support complex multi-table joins in the same way as relational databases, meaning transactional systems such as payments or accounting are generally better handled in SQL databases. Second, MongoDB provides weaker ACID guarantees across multiple documents, which can make strict transaction consistency harder to enforce compared to MySQL.

In addition, data redundancy can occur because related data may be duplicated across documents. Backup size and update operations may therefore increase. Finally, query optimization requires careful index design, since unindexed queries can become slow as data volume grows.