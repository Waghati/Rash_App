class Course {
  final String id;
  final String name;
  final String description;
  final String subject;
  final String grade;
  final String instructorId;
  final String instructorName;
  final int totalLessons;
  final int completedLessons;
  final double progress;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final List<String> tags;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.grade,
    required this.instructorId,
    required this.instructorName,
    required this.totalLessons,
    this.completedLessons = 0,
    this.progress = 0.0,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    this.tags = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      subject: json['subject'],
      grade: json['grade'],
      instructorId: json['instructor_id'],
      instructorName: json['instructor_name'],
      totalLessons: json['total_lessons'],
      completedLessons: json['completed_lessons'] ?? 0,
      progress: (json['progress'] ?? 0.0).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isActive: json['is_active'] ?? true,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subject': subject,
      'grade': grade,
      'instructor_id': instructorId,
      'instructor_name': instructorName,
      'total_lessons': totalLessons,
      'completed_lessons': completedLessons,
      'progress': progress,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive,
      'tags': tags,
    };
  }

  Course copyWith({
    String? id,
    String? name,
    String? description,
    String? subject,
    String? grade,
    String? instructorId,
    String? instructorName,
    int? totalLessons,
    int? completedLessons,
    double? progress,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    List<String>? tags,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      instructorId: instructorId ?? this.instructorId,
      instructorName: instructorName ?? this.instructorName,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      progress: progress ?? this.progress,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
    );
  }
}

class Assignment {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final String courseName;
  final String subject;
  final DateTime dueDate;
  final DateTime createdDate;
  final AssignmentStatus status;
  final int totalPoints;
  final int? earnedPoints;
  final String difficulty;
  final List<String> attachments;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.courseName,
    required this.subject,
    required this.dueDate,
    required this.createdDate,
    required this.status,
    required this.totalPoints,
    this.earnedPoints,
    required this.difficulty,
    this.attachments = const [],
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['course_id'],
      courseName: json['course_name'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['due_date']),
      createdDate: DateTime.parse(json['created_date']),
      status: AssignmentStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => AssignmentStatus.pending,
      ),
      totalPoints: json['total_points'],
      earnedPoints: json['earned_points'],
      difficulty: json['difficulty'],
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'course_id': courseId,
      'course_name': courseName,
      'subject': subject,
      'due_date': dueDate.toIso8601String(),
      'created_date': createdDate.toIso8601String(),
      'status': status.name,
      'total_points': totalPoints,
      'earned_points': earnedPoints,
      'difficulty': difficulty,
      'attachments': attachments,
    };
  }
}

enum AssignmentStatus {
  pending,
  inProgress,
  completed,
  overdue,
  graded
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String courseId;
  final int orderIndex;
  final Duration estimatedDuration;
  final LessonType type;
  final bool isCompleted;
  final DateTime? completedAt;
  final Map<String, dynamic>? content;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.orderIndex,
    required this.estimatedDuration,
    required this.type,
    this.isCompleted = false,
    this.completedAt,
    this.content,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['course_id'],
      orderIndex: json['order_index'],
      estimatedDuration: Duration(minutes: json['estimated_duration_minutes']),
      type: LessonType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => LessonType.text,
      ),
      isCompleted: json['is_completed'] ?? false,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'course_id': courseId,
      'order_index': orderIndex,
      'estimated_duration_minutes': estimatedDuration.inMinutes,
      'type': type.name,
      'is_completed': isCompleted,
      'completed_at': completedAt?.toIso8601String(),
      'content': content,
    };
  }
}

enum LessonType {
  text,
  video,
  audio,
  interactive,
  quiz,
  assignment
}
