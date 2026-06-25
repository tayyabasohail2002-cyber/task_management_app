class Task {
  final int? id;
  final String subject;
  final String topic;
  final bool completed;
  final String? date;

  Task({
    this.id,
    required this.subject,
    required this.topic,
    this.completed = false,
    this.date,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      subject: json["subject"] ?? "",
      topic: json["topic"] ?? "",
      completed: json["completed"] == true ||
          json["completed"] == 1,
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subject": subject,
      "topic": topic,
      "completed": completed,
      "date": date,
    };
  }
}