# 🛍️ e_commerce_app

A Flutter-based **E-Commerce application** built with **Clean Architecture**, **Cubit state management**, and **Dependency Injection** using `get_it`.

---

## 🚀 Features

- 🛒 Browse products & categories
- 🧾 Product details with reviews
- 🛍️ Cart management
- 👤 Authentication (with biometrics via `local_auth`)
- 🌐 API integration using `dio`
- 📡 Network handling with `connectivity_plus`
- 💾 Local storage with `hive_flutter`

---

## 📦 Dependencies

Key packages used in this project:

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) → State management (Cubit)
- [`get_it`](https://pub.dev/packages/get_it) → Dependency injection
- [`go_router`](https://pub.dev/packages/go_router) → Navigation
- [`dio`](https://pub.dev/packages/dio) → Networking
- [`hive_flutter`](https://pub.dev/packages/hive_flutter) → Local storage
- [`local_auth`](https://pub.dev/packages/local_auth) → Biometric authentication
- [`connectivity_plus`](https://pub.dev/packages/connectivity_plus) → Network status

---

## 🏗️ Architecture

The project follows **Clean Architecture + Cubit Injection**:

- `core/` → Constants, services, dependency injection, database, networking
- `features/` → App modules (auth, product, cart, etc.)
- `shared/` → Common widgets, models, and themes
- `main.dart` → Application entry point

---

## 📱 Download APK

👉 [Click here to download e_commerce_app APK](https://github.com/Pugalesh-KM/e_commerce_app/blob/main/assets/apk/e_commerce_app.apk)

---

## ▶️ Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/Pugalesh-KM/e_commerce_app.git
cd e_commerce_app
