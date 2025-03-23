# 📦 **Inventory Management Flutter  System with Google Sheets Integration**



---

## 📚 **Project Overview**

The **Inventory Management System** is a cross-platform application built with **Flutter** to manage stock levels efficiently. The app uses **Google Sheets** as a backend to store and sync inventory data in real time using **Google Apps Script**.

---



## Screenshots




## 🌗 **Dark & Light Mode Screens**

### 🌙 **Dark Theme Screens**

<p align="center">

  <img src="https://github.com/user-attachments/assets/bfa3955a-57a1-48c4-a60a-2d399dd98078" width="30%" alt="Dark Home Screen 2" />
  <img src="https://github.com/user-attachments/assets/23f96067-3007-4544-ad20-e696f8c7dad1" width="30%" alt="Dark Home Screen 1" />

  <img src="https://github.com/user-attachments/assets/d5bdf3ad-3951-4b9b-a9b9-0515ea9379b6" width="30%" alt="Low Stock Alert Dark" />
</p>

<p align="center">

  <img src="https://github.com/user-attachments/assets/070062a4-7662-4e0a-808e-38ceccff8084" width="30%" alt="Dark Home Screen 2" />
  <img src="https://github.com/user-attachments/assets/466fe570-945e-4fad-83f3-1d9a4b16f80f" width="30%" alt="Dark Home Screen 1" />

</p>



---



### ☀️ **Light Theme Screens**



<p align="center">
  <img src="https://github.com/user-attachments/assets/52330f8c-8bc5-4f3e-9286-2abcbe263258" width="30%" alt="Low Stock Alert Light" />
  <img src="https://github.com/user-attachments/assets/71ca7ccf-0b25-4bc8-8c8a-1d4b7939e6e2" width="30%" alt="Light Home Screen" />
  
  <img src="https://github.com/user-attachments/assets/2c889de4-ebfa-47e2-a760-636f7176474e" width="30%" alt="Manage Add Inventory" />
</p>

---







## 🎯 **Key Features**

1. ✅ **Home Screen:**  
   - Displays a list of inventory items with quantity, price, and stock status.
   - Highlights low-stock items in red when below the threshold.
   - Button to navigate to the Stock Management screen.

2. ✅ **Stock Management Screen:**
   - Add, modify, and delete inventory items.
   - Edit price, quantity, and threshold.
   - Updates Google Sheets dynamically.

3. ✅ **Stock In/Out Screen:**
   - Mark inventory changes as `IN` (Added) or `OUT` (Removed).
   - Logs all transactions in Google Sheets.
   - Raises alerts for low-stock items.

4. ✅ **Google Sheets Integration:**
   - Real-time data sync using Google Apps Script.
   - Inventory, transactions, and notifications managed in separate tabs.

5. ✅ **Low Stock Alerts:**
   - Triggers notifications when stock falls below the defined threshold.

---

## 📱 **Screens and UI Flow**

### 🏠 **1. Home Screen**
- Displays inventory items and their stock levels.
- Highlights low-stock items with a red alert.
- Button to access Stock Management or Stock In/Out screen.


---

### 📦 **2. Stock Management Screen**
- Add, modify, and delete inventory items.
- Updates stock data and reflects changes in Google Sheets.


---

### 🔄 **3. Stock In/Out Screen**
- Mark stock as IN or OUT.
- Update stock quantity and transaction log.
- Notify admin if stock falls below threshold.


---

## 🔗 **Google Sheets Integration**

The app interacts with Google Sheets through **Google Apps Script**. The script performs CRUD operations on the Google Sheet, which contains multiple tabs:

- 📄 `Inventory` → Stores product details (name, price, quantity, etc.)
- 📄 `Transactions` → Logs all stock changes (IN/OUT with timestamps)
- 📄 `Notifications` → Stores low-stock alerts for admin review

---




## ✅ **Google Apps Script Endpoints**

| Method   | Endpoint Description                  |
|----------|---------------------------------------|
| `GET`    | Fetch inventory data                  |
| `POST`   | Add new inventory item                |
| `PUT`    | Update existing item                  |
| `DELETE` | Mark item as inactive or delete item  |

---

## 🛠️ **Packages Used**

Below are the key packages used to implement this project:

| Package Name              | Usage                                  |
|--------------------------|----------------------------------------|
| `gsheet`              | Interact with Google Sheets API       |
| `http`                    | Handle API requests                   |
| `provider`                | Manage app-wide state                 |
| `fl_chart`                | Visualize data using graphs           |
| `flutter_local_notifications` | Send local notifications           |
| `google_fonts`            | Use Google Fonts for custom typography |

---

## Getting Started:

To get started with the Inventory Flutter app, follow these steps:

##  1. Clone the repository to your local machine:

```bash
git clone <repository_url>
Navigate to the project directory:
 
cd <project_directory>
Install dependencies:
bash

flutter pub get
Set up Firebase:

## Create a Firebase project in the Firebase console.
Add the Firebase configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) to the android/app and ios directories, respectively.
Launch the application:


flutter run
Features Under Development:
Enhanced Ui -Ux 
Data Analytics: Implementing analytics to provide insights into sales and inventory management.
Customization Options: Adding options for users to customize sheet formats and item categories.
Contributing:
Contributions to the Inventory Flutter app are welcome! Feel free to fork the repository and submit pull requests with your enhancements or bug fixes.

License:
This project is licensed under the MIT License - see the LICENSE file for details.

Happy billing with Inventory! 🚀

