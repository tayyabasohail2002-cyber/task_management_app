import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SmartInsightsScreen extends StatefulWidget {
  @override
  State<SmartInsightsScreen> createState() => _SmartInsightsScreenState();
}

class _SmartInsightsScreenState extends State<SmartInsightsScreen> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadInsights();
  }

  Future<void> loadInsights() async {
    try {
      final res = await ApiService.getAnalytics();
      setState(() => data = res);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    int total = data!['total_tasks'];
    int completed = data!['completed_tasks'];
    double progress = data!['progress'];
    int score = (progress * 100).toInt();

    List insights = data!['insights'] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: const Text("🤖 Smart Insights"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🧠 AI HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF9D7BFF)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  Icon(Icons.psychology, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "AI Study Assistant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📊 STATS CARDS
            Row(
              children: [
                Expanded(child: _statCard("Total", "$total", Colors.blue)),
                const SizedBox(width: 10),
                Expanded(child: _statCard("Done", "$completed", Colors.green)),
              ],
            ),

            const SizedBox(height: 10),

            _statCard("AI Score", "$score%", Colors.deepPurple),

            const SizedBox(height: 20),

            // 📈 PROGRESS BAR
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Progress",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 💡 AI INSIGHTS
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "💡 AI Insights",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            ...insights.map((text) => _insightCard(text)).toList(),

            const SizedBox(height: 20),

            // 🔥 RECOMMENDATIONS
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "🔥 Recommendations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            _tip("📌 Focus on 2–3 subjects per day"),
            _tip("⏱ Use Pomodoro for better focus"),
            _tip("🔥 Maintain your daily streak"),
          ],
        ),
      ),
    );
  }

  // 📊 STAT CARD
  Widget _statCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // 💡 INSIGHT CARD
  Widget _insightCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // 🔥 TIP
  Widget _tip(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text),
    );
  }
}