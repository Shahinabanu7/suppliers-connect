# 📦 Supplier Connect App – Full Stack MVP (Flutter + PHP)

Welcome to the **SmartSupply App**, a mini full-stack MVP where restaurant users can log in, browse suppliers, view there products, add to cart, and place orders.  
This project demonstrates full-stack capability using **Flutter (Frontend)** and **PHP (Backend)** hosted on **AWS EC2** with **MySQL**.

---

## 🚀 Project Overview

This app allows restaurant users to:
- 🔐 Login using credentials
- 🧾 View suppliers (name, logo, rating, category)
- 📦 View products from a supplier
- 🛒 Add items to cart, update quantity, remove
- 📤 Place an order (with order success confirmation)

---

## 📱 Flutter Frontend

- Framework: Flutter
- State Management: **Provider**
- UI Design: Material 3, MVVM pattern
- Data Persistence: SharedPreferences
- Folder: `/supplier_connect_app`

---

## 🛠️ Backend API (PHP + MySQL)

- Language: PHP (Raw PHP)
- RESTful API with JSON
- Token-based Authentication (hardcoded)
- Hosted: **AWS EC2**
- Folder: `/backend-api`

---

## 🧪 Sample Login Credentials

| Username              | Password   |
|------------------------|------------|
| `admin@supplier.com`    | `123456` |

These are dummy credentials used for authentication via the `POST /login` API.

---

## 🔗 Live API URL (Hosted on AWS EC2)
"http://3.122.45.88/supplierconnect"

Your backend API is hosted on AWS EC2 and publicly accessible.

## 📡 API Endpoint Descriptions

| Endpoint                | Method | Description                        |
|-------------------------|--------|------------------------------------|
| `/login`                | POST   | Authenticate user using credentials |
| `/supplier`            | GET    | Get list of all suppliers           |
| `/suppliersd.php?id=$id`  | GET    | Get products from specific supplier |
| `/orders`               | POST   | Submit an order with cart items     |

## ✅ How to Test the Order Process

Follow these steps to test the full order flow in the Supplier Connect App:

1. **Login**
   - Open the app and go to the Login screen.
   - Enter the sample credentials:
     - Email: `admin@supplier.com`
     - Password: `admin123`
   - Tap the **Login** button.

2. **View Suppliers**
   - After logging in, you will see the Supplier List screen.
   - Browse the list of suppliers displaying their logo, name, rating, and categories.

3. **View Supplier Products**
   - Tap on a supplier to view their product list.
   - Each product shows its image, name, price, and an **Add to Cart** button.

4. **Add Products to Cart**
   - Tap **Add to Cart** on any product to add it to your shopping cart.
   - You can add multiple products from different suppliers.

5. **Review Cart**
   - Navigate to the Cart screen.
   - Here, you can:
     - See all added items.
     - Update the quantity or remove items.
     - View the total cost of all products.

6. **Place an Order**
   - Tap the **Place Order** button.
   - The app will send your cart details to the backend `/orders` API.

7. **Order Success**
   - Upon successful order submission, you will see a confirmation/success screen.

## 📲 APK Build
You can download the working APK here: 
[Download SumartSupply App APK] (https://drive.google.com/file/d/1it-ORZvmWmZIoGOiXL9JCeFJdsA6Sdh_/view?usp=sharing)
