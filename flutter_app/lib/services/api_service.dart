import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  // ================= LOGIN =================

  static Future<bool> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 200;
  }

  // ================= REGISTER =================

  static Future<bool> register(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 200;
  }

  // ================= GET TASKS =================

  static Future<List<Task>> getTasks() async {
    final response = await http.get(
      Uri.parse("$baseUrl/tasks"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data
          .map((task) => Task.fromJson(task))
          .toList();
    }

    throw Exception("Failed to load tasks");
  }

  // ================= ADD TASK =================

  static Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tasks"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add task");
    }
  }

  // ================= COMPLETE TASK =================

  static Future<void> toggleTask(int id) async {
    final response = await http.put(
      Uri.parse("$baseUrl/tasks/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update task");
    }
  }

  // ================= DELETE TASK =================

  static Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/tasks/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete task");
    }
  }

  // ================= ANALYTICS =================

  static Future<Map<String, dynamic>> getAnalytics() async {
    final response = await http.get(
      Uri.parse("$baseUrl/analytics"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed analytics");
  }

  // ================= STREAK =================

  static Future<Map<String, dynamic>> getStreak() async {
    final response = await http.get(
      Uri.parse("$baseUrl/streak"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load streak");
  }
}