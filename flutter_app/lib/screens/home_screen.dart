import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await ApiService.getTasks();

    if (!mounted) return;

    setState(() {
      tasks = data;
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    int completed = tasks.where((t) => t.completed).length;
    double progress = tasks.isEmpty ? 0 : completed / tasks.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Fokas Flo"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
             Navigator.pushNamed(context, AppRoutes.dashboard);
            },
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  // 🎯 HEADER CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF9D7BFF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Stay Focused 👀",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You're doing great!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${(progress * 100).toStringAsFixed(0)}% completed",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ⚡ QUICK ACTIONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    
                      _actionCard(
                        icon: Icons.task,
                        title: "Insights",
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.tasks);
                        },
                      ),

                      _actionCard(
                        icon: Icons.timer,
                        title: "Pomodoro",
                        onTap: () {
                        Navigator.pushNamed(context, AppRoutes.pomodoro);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 📋 TASK LIST PREVIEW
                  Expanded(
                    child: tasks.isEmpty
                        ? const Center(child: Text("No tasks yet"))
                        : ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];

                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  title: Text(task.subject),
                                  subtitle: Text(task.topic),
                                  trailing: Icon(
                                    task.completed
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: task.completed
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  onTap: () async {
                                    await ApiService.toggleTask(task.id!);
                                    loadTasks();
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTask);
        },
      ),
    );
  }

  // 🔧 ACTION CARD
  Widget _actionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.deepPurple, size: 30),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
