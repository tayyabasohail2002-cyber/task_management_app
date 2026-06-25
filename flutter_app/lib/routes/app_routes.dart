import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';
import '../screens/task_screen.dart';
import '../screens/add_task_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';



import '../screens/smart_insights_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/pomodoro_screen.dart';

class AppRoutes {
  static const splash = "/splash";
  static const onboarding = "/onboarding";
  static const home = "/";
  static const tasks = "/tasks";
  static const addTask = "/add-task";
  static const login = "/login";
  static const register = "/register";
  
  
  static const insights = "/insights";
  static const dashboard = "/dashboard";
  static const pomodoro = "/pomodoro";

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    onboarding: (context) => OnboardingScreen(),
    home: (context) => HomeScreen(),
    tasks: (context) => TaskScreen(),
    addTask: (context) => AddTaskScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    
   
    insights: (context) => SmartInsightsScreen(),
    dashboard: (context) => DashboardScreen(),
    pomodoro: (context) => PomodoroScreen(),
  };
}