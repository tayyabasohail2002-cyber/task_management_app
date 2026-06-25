import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../routes/app_routes.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final data = await ApiService.getTasks();

      setState(() {
        tasks = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> toggleTask(Task task) async {
    await ApiService.toggleTask(task.id!);

    await loadTasks();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            task.completed
                ? "Task marked pending"
                : "Task completed 🎉",
          ),
        ),
      );
    }
  }

  Future<void> deleteTask(Task task) async {
    bool confirm = await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Delete Task"),
            content: const Text(
              "Are you sure you want to delete this task?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirm) return;

    await ApiService.deleteTask(task.id!);

    await loadTasks();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task deleted"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: const Text("📋 Your Tasks"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.task_alt,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "No tasks yet",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return _taskCard(task);
                  },
                ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            AppRoutes.addTask,
          );

          loadTasks();
        },
      ),
    );
  }

  Widget _taskCard(Task task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            task.completed ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [

          // COMPLETE BUTTON
          IconButton(
            icon: Icon(
              task.completed
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.completed
                  ? Colors.green
                  : Colors.grey,
              size: 30,
            ),
            onPressed: () => toggleTask(task),
          ),

          const SizedBox(width: 10),

          // TASK INFO
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  task.subject,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: task.completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  task.topic,
                  style: TextStyle(
                    color: Colors.grey[600],
                    decoration: task.completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                if (task.date != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 6),
                    child: Text(
                      task.date!.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // DELETE BUTTON
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () => deleteTask(task),
          ),
        ],
      ),
    );
  }
}