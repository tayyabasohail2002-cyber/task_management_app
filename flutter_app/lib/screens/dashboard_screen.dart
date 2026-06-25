import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? analytics;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      final data = await ApiService.getAnalytics();

      setState(() {
        analytics = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final total = analytics?["total_tasks"] ?? 0;
    final completed = analytics?["completed_tasks"] ?? 0;
    final pending = analytics?["pending_tasks"] ?? 0;
    final progress = (analytics?["progress"] ?? 0.0).toDouble();
    final score = analytics?["score"] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: const Text("Dashboard 📊"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: loadDashboard,
        child: const Icon(Icons.refresh),
      ),

      body: RefreshIndicator(
        onRefresh: loadDashboard,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // Productivity Score Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF9D7BFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.white,
                    size: 50,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "$score%",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const Text(
                    "Productivity Score",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Stats
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "Total",
                    total.toString(),
                    Icons.list_alt,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    "Done",
                    completed.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    "Pending",
                    pending.toString(),
                    Icons.pending_actions,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Progress
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Overall Progress",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${(progress * 100).toStringAsFixed(0)}% Completed",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "AI Insights 🤖",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...(analytics?["insights"] as List<dynamic>)
                .map(
                  (item) => Container(
                    margin:
                        const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lightbulb,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(item.toString()),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }
}