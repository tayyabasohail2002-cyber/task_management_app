# 📚 Smart Study Planner

A Flutter-based productivity and study management application designed to help students organize tasks, track progress, maintain study streaks, and improve productivity using smart insights.

---

## 🚀 Features

### 🔐 Authentication
- User Registration
- User Login
- Local SQLite User Storage
- Secure Navigation Flow

### 📋 Task Management
- Add Study Tasks
- View All Tasks
- Mark Tasks as Completed
- Delete Tasks
- Task Progress Tracking

### 📊 Dashboard
- Total Tasks Overview
- Completed Tasks Statistics
- Progress Percentage
- Productivity Summary


### 🤖 Smart Insights
- Productivity Score
- Performance Analysis
- Weak Subject Detection
- Personalized Recommendations

### ⏱ Pomodoro Timer
- Focus Sessions
- Productivity Enhancement
- Time Management Support


### 🎨 Modern UI
- Gradient Design
- Responsive Layout
- Material Design Components
- Clean User Experience

---

## 🛠 Technologies Used

### Frontend
- Flutter
- Dart

### Backend
- FastAPI
- Python

### Database
- SQLite

### Packages
- http
- shared_preferences
- table_calendar
- flutter_local_notifications

---

## 📱 Screens

### Splash Screen
App startup screen.
![alt text](<Screenshot 2026-06-25 200137.png>)

### Onboarding Screen
Introduction to app features.
![alt text](<Screenshot 2026-06-25 195428-1.png>)
![alt text](<Screenshot 2026-06-25 195439.png>)
![alt text](<Screenshot 2026-06-25 195457.png>)

### Login Screen
User authentication.
![alt text](<Screenshot 2026-06-25 195509.png>)

### Register Screen
Create new account.
![alt text](<Screenshot 2026-06-25 195519.png>)

### Home Screen
Central dashboard for navigation.
![alt text](<Screenshot 2026-06-25 195245.png>)

### Task Screen
Manage study tasks.
![alt text](<Screenshot 2026-06-25 195348.png>)

### Add Task Screen
Create new tasks.
![alt text](<Screenshot 2026-06-25 195318.png>)

### Dashboard Screen
Track productivity.
![alt text](<Screenshot 2026-06-25 195205.png>)

### Smart Insights Screen
AI-inspired productivity analysis.
![alt text](<Screenshot 2026-06-25 195259.png>)

### Pomodoro Screen
Focus timer.
![alt text](<Screenshot 2026-06-25 195229.png>)


---

## 📂 Project Structure
lib/
│
├── models/
│ └── task_model.dart
│
├── services/
│ ├── api_service.dart
│ └── streak_service.dart
│
├── screens/
│ ├── splash_screen.dart
│ ├── onboarding_screen.dart
│ ├── login_screen.dart
│ ├── register_screen.dart
│ ├── home_screen.dart
│ ├── task_screen.dart
│ ├── add_task_screen.dart
│ ├── dashboard_screen.dart
│ ├── streak_screen.dart
│ ├── smart_insights_screen.dart
│ ├── profile_screen.dart
│ └── pomodoro_screen.dart
│
├── routes/
│ └── app_routes.dart
│
└── main.dart


---

## ⚙️ Installation

### Clone Repository

```bash
git clone https://github.com/yourusername/smart-study-planner.git
Navigate to Project
cd smart-study-planner
Install Dependencies
flutter pub get
Run Backend
cd backend

python -m venv venv

venv\Scripts\activate

pip install fastapi uvicorn

uvicorn main:app --reload

Backend runs at:

http://127.0.0.1:8000
Run Flutter App
flutter run
📈 Productivity Logic
Productivity Score
Completed Tasks / Total Tasks × 100
Streak Logic
Complete study tasks daily
↓
Increase streak count
↓
Miss a day
↓
Streak resets
Smart Insights

Examples:

"Great consistency! Keep going 🔥"
"Try Pomodoro sessions for better focus ⏱"
"You are weak in Mathematics. Revise today 📚"
🧪 Testing

The application has been tested for:

Navigation
Task Creation
Task Completion
Login & Registration
Analytics Calculation
Streak Tracking
Backend API Communication