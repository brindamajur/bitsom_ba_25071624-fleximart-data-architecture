// ===============================================
// mongodb_operations.js - FlexiMart NoSQL Tasks
// Database: fleximart_nosql
// Collection: products
// ===============================================


// ------------------------------------------------
// Operation 1: Load Data (Run in terminal, not mongosh)
// ------------------------------------------------
//
mongoimport --db fleximart_nosql --collection products --file part2-nosql/products_catalog.json --jsonArray
//
// ------------------------------------------------


// select database (creates if not exists)
//use fleximart_nosql;


// ------------------------------------------------
// Operation 2: Basic Query (Electronics < 50000)
// Return: name, price, stock
// ------------------------------------------------
db.products.find(
  {
    category: "Electronics",
    price: { $lt: 50000 }
  },
  {
    _id: 0,
    name: 1,
    price: 1,
    stock: 1
  }
);


// ------------------------------------------------
// Operation 3: Review Analysis
// Products with average rating >= 4.0
// ------------------------------------------------
db.products.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$product_id",
      name: { $first: "$name" },
      avg_rating: { $avg: "$reviews.rating" }
    }
  },
  { $match: { avg_rating: { $gte: 4.0 } } }
]);


// ------------------------------------------------
// Operation 4: Update Operation
// Add review to product ELEC001
// ------------------------------------------------
db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: ISODate()
      }
    }
  }
);


// ------------------------------------------------
// Operation 5: Complex Aggregation
// Average price by category
// ------------------------------------------------
db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  { $sort: { avg_price: -1 } }
]);
