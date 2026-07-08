# 📚 Smart Study Planner

A modern **Flutter** productivity application developed as part of the **Flutter Developers Internship (Cycle 2 - Weeks 4–6)**. The application helps students manage study tasks, track productivity, improve focus using the Pomodoro technique, and securely manage their data using **Firebase Authentication**, **Cloud Firestore**, and **Provider** state management.

---

# 🚀 Features

## 🔐 Firebase Authentication (Week 5)

- User Registration
- User Login
- Secure Email & Password Authentication
- Persistent Login Session
- Logout Functionality

---

## 👤 User Profile (Week 4 & 5)

- Fetch User Profile
- Display Name
- Display Email
- Display Profile Picture
- Firestore User Data Retrieval

---

## 📋 Task Management (Week 6)

- Add Study Tasks
- View Tasks
- Update Task Status
- Delete Tasks
- Pull-to-Refresh
- Task Progress Tracking

---

## 📊 Dashboard

- Total Tasks
- Completed Tasks
- Pending Tasks
- Productivity Score
- Progress Percentage
- Refresh Dashboard

---

## 🤖 Smart Insights

- Productivity Analysis
- Study Recommendations
- Personalized Tips
- AI Productivity Score

---

## ⏱ Pomodoro Timer

- 25-Minute Focus Sessions
- Productivity Enhancement
- Study Timer

---

## 🔔 Notifications

- Local Notifications
- Study Reminder Alerts
- Pomodoro Completion Notifications

---

## 📦 Provider State Management (Week 6)

- TaskProvider
- DashboardProvider
- Real-time UI Updates
- Centralized State Management
- Efficient Performance

---

## 🎨 UI Features

- Material Design
- Gradient Theme
- Responsive Layout
- Loading Indicators
- Error Handling
- Smooth Navigation
- Pull-to-Refresh

---

# 🛠 Technologies Used

## Frontend

- Flutter
- Dart

## Backend / Cloud

- Firebase Authentication
- Cloud Firestore
- Firebase Core

## State Management

- Provider

## Notifications

- flutter_local_notifications

## Networking

- HTTP Package
- JSON Parsing

## Local Storage

- Shared Preferences

---

# 📱 Screens

- Splash Screen
- Onboarding Screens
- Login
- Register
- Home
- Task Management
- Add Task
- Dashboard
- Smart Insights
- Pomodoro Timer
- User Profile

---

# 📂 Project Structure

```text
lib/
│
├── models/
│   ├── task_model.dart
│   └── user_model.dart
│
├── providers/
│   ├── task_provider.dart
│   └── dashboard_provider.dart
│
├── services/
│   ├── firebase_auth_service.dart
│   ├── firestore_service.dart
│   ├── api_service.dart
│   └── notification_service.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── home_screen.dart
│   ├── task_screen.dart
│   ├── add_task_screen.dart
│   ├── dashboard_screen.dart
│   ├── smart_insights_screen.dart
│   ├── pomodoro_screen.dart
│   └── profile_screen.dart
│
├── routes/
│   └── app_routes.dart
│
├── firebase_options.dart
│
└── main.dart
```

---

# ⚙ Installation

## Clone Repository

```bash
git clone https://github.com/your-username/smart-study-planner.git
```

Navigate to the project

```bash
cd smart-study-planner
```

Install dependencies

```bash
flutter pub get
```

---

# 🔥 Firebase Setup

## Install Firebase CLI

```bash
npm install -g firebase-tools
```

Login

```bash
firebase login
```

Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

Configure Firebase

```bash
flutterfire configure
```

Run the application

```bash
flutter run
```

---

# 📡 Week 4 - API Integration & Networking

### ✔ HTTP Requests

- Integrated REST API using the **http** package.

### ✔ JSON Parsing

- Parsed API responses into Dart models.

### ✔ User Profile

- Fetches user information.
- Displays name, email, and profile information.

### ✔ Error Handling

- Network exception handling.
- User-friendly error messages.
- Retry functionality.

### ✔ Loading Indicators

- CircularProgressIndicator during API requests.

---

# 🔥 Week 5 - Firebase Authentication & Firestore

### ✔ Firebase Setup

- Firebase Core
- Firebase Authentication
- Cloud Firestore

### ✔ Authentication

- User Registration
- User Login
- Logout
- Persistent Authentication

### ✔ Firestore

- Store User Name
- Store Email
- Retrieve User Details
- Display User Profile

---

# 📦 Week 6 - Provider State Management

### ✔ TaskProvider

- Load Tasks
- Add Task
- Delete Task
- Update Task Status
- Automatic UI Refresh

### ✔ DashboardProvider

- Dashboard Analytics
- Productivity Score
- Progress Tracking

### ✔ Performance Improvements

- Reduced unnecessary widget rebuilds
- Centralized business logic
- Better project architecture

---

# 📊 Productivity Logic

## Progress Calculation

```
Completed Tasks ÷ Total Tasks × 100
```

## Productivity Score

Calculated using

- Completed Tasks
- Pending Tasks
- Overall Progress

---

# 🤖 Smart Insights

Example recommendations

- Great consistency! Keep studying.
- Try another Pomodoro session.
- Complete pending tasks.
- Maintain your study streak.
- Stay focused on today's goals.

---

# 🧪 Testing

The application has been tested for

- ✅ Firebase Registration
- ✅ Firebase Login
- ✅ Firestore CRUD Operations
- ✅ HTTP API Requests
- ✅ JSON Parsing
- ✅ Error Handling
- ✅ Loading Indicators
- ✅ Provider State Management
- ✅ Task CRUD Operations
- ✅ Dashboard Updates
- ✅ Smart Insights
- ✅ Pomodoro Timer
- ✅ Local Notifications

---

# 🎯 Internship Tasks Covered

## ✅ Week 4 – API Integration & Networking

- HTTP Requests using http package
- JSON Parsing
- User Profile Screen
- Display User Details
- Loading Indicators
- Error Handling
- API Integration

---

## ✅ Week 5 – Firebase Authentication & Database

- Firebase Configuration
- Email/Password Authentication
- Login Screen
- Registration Screen
- Firestore Integration
- Store User Details
- Retrieve User Details
- Profile Screen

---

## ✅ Week 6 – Provider State Management

- Provider Implementation
- TaskProvider
- DashboardProvider
- Real-time UI Updates
- Refactored setState to Provider
- Improved Performance
- Better Project Architecture

---

# ⭐ Bonus Features

- Splash Screen
- Onboarding Screens
- Dashboard Analytics
- Smart Insights
- Pomodoro Timer
- Local Notifications
- Responsive UI
- Modern Material Design
- Pull-to-Refresh
- Firebase Authentication
- Cloud Firestore
- Provider State Management

---

# 📹 Project Demonstration

The project includes a **4–5 minute walkthrough video** demonstrating:

- User Registration
- User Login
- Task Management
- Dashboard
- Smart Insights
- Pomodoro Timer
- User Profile
- Provider State Management
- Firebase Authentication
- Firestore Integration

---

# 👩‍💻 Author

**Tayyaba Sohail**

Flutter Developer | Firebase Developer | Python Developer
