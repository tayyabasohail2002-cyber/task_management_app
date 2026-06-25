import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<Task> allTasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    allTasks = await ApiService.getTasks();
    setState(() {});
  }

  List<Task> getTasksForDay(DateTime day) {
    return allTasks.where((task) {
      if (task.date == null) return false;

      DateTime taskDate = DateTime.parse(task.date!);

      return taskDate.year == day.year &&
          taskDate.month == day.month &&
          taskDate.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> dailyTasks = getTasksForDay(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text("📅 Study Calendar"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // 📅 CALENDAR
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),

            selectedDayPredicate: (day) =>
                isSameDay(selectedDay, day),

            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });
            },

            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 📋 TASKS OF DAY
          Expanded(
            child: dailyTasks.isEmpty
                ? const Center(child: Text("No tasks for this day"))
                : ListView.builder(
                    itemCount: dailyTasks.length,
                    itemBuilder: (context, index) {
                      final task = dailyTasks[index];

                      return Card(
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}