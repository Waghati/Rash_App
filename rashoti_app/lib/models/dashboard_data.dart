class DashboardStats {
  final Map<String, dynamic> data;

  DashboardStats(this.data);

  T getValue<T>(String key, T defaultValue) {
    return data[key] ?? defaultValue;
  }

  int get totalCourses => getValue('totalCourses', 0);
  int get completedAssignments => getValue('completedAssignments', 0);
  double get averageScore => getValue('averageScore', 0.0);
  int get studyStreak => getValue('studyStreak', 0);
  double get hoursStudied => getValue('hoursStudied', 0.0);
  String get rank => getValue('rank', 'Unranked');

  // Teacher specific
  int get totalStudents => getValue('totalStudents', 0);
  int get totalClasses => getValue('totalClasses', 0);
  double get averagePerformance => getValue('averagePerformance', 0.0);
  int get pendingGrading => getValue('pendingGrading', 0);
  int get upcomingClasses => getValue('upcomingClasses', 0);
  double get satisfaction => getValue('satisfaction', 0.0);

  // Parent specific
  int get totalChildren => getValue('totalChildren', 0);
  int get totalAssignments => getValue('totalAssignments', 0);
  int get upcomingEvents => getValue('upcomingEvents', 0);
  String get monthlyProgress => getValue('monthlyProgress', '0%');
}

class RecentActivity {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime date;
  final Map<String, dynamic> metadata;

  RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    this.metadata = const {},
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] is DateTime
          ? json['date']
          : DateTime.parse(json['date'].toString()),
      metadata: json['metadata'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'metadata': metadata,
    };
  }

  // Helper getters for common metadata
  int? get score => metadata['score'];
  String? get subject => metadata['subject'];
  int? get progress => metadata['progress'];
  String? get child => metadata['child'];
}
