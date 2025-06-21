# 📦 Supplier Connect App – Full Stack MVP (Flutter + PHP)

Welcome to the **Supplier Connect App**, a mini full-stack MVP where restaurant users can log in, browse suppliers, view products, add to cart, and place orders.  
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
- Folder: `/flutter-app`

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
| `admin@example.com`    | `admin123` |

These are dummy credentials used for authentication via the `POST /login` API.

---

## 🔗 Live API URL (Hosted on AWS EC2)

