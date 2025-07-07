import 'package:flutter/foundation.dart';

class DashboardData {
  final Map<String, dynamic> stats;
  final List<dynamic> recentActivity;
  final List<dynamic> assignments;
  final List<dynamic> courses;

  DashboardData({
    required this.stats,
    required this.recentActivity,
    required this.assignments,
    required this.courses,
  });
}

class DashboardProvider extends ChangeNotifier {
  DashboardData? _studentData;
  DashboardData? _teacherData;
  DashboardData? _parentData;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  DashboardData? get studentData => _studentData;
  DashboardData? get teacherData => _teacherData;
  DashboardData? get parentData => _parentData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Load student dashboard data
  Future<void> loadStudentDashboard(String studentId) async {
    _setLoading(true);
    _setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _studentData = DashboardData(
        stats: {
          'totalCourses': 5,
          'completedAssignments': 23,
          'averageScore': 85.5,
          'studyStreak': 7,
          'hoursStudied': 45.5,
          'rank': 'Top 10%',
        },
        recentActivity: [
          {
            'type': 'assignment_completed',
            'title': 'Mathematics Quiz 3',
            'score': 92,
            'date': DateTime.now().subtract(const Duration(hours: 2)),
            'subject': 'Mathematics',
          },
          {
            'type': 'lesson_completed',
            'title': 'Chemical Reactions',
            'progress': 100,
            'date': DateTime.now().subtract(const Duration(hours: 5)),
            'subject': 'Science',
          },
          {
            'type': 'badge_earned',
            'title': 'Science Explorer',
            'description': 'Completed 10 science lessons',
            'date': DateTime.now().subtract(const Duration(days: 1)),
          },
        ],
        assignments: [
          {
            'id': '1',
            'title': 'Algebra Practice Set',
            'subject': 'Mathematics',
            'dueDate': DateTime.now().add(const Duration(days: 3)),
            'status': 'pending',
            'difficulty': 'medium',
          },
          {
            'id': '2',
            'title': 'Essay: Climate Change',
            'subject': 'Languages',
            'dueDate': DateTime.now().add(const Duration(days: 5)),
            'status': 'in_progress',
            'difficulty': 'hard',
          },
          {
            'id': '3',
            'title': 'Programming Basics',
            'subject': 'Computer Studies',
            'dueDate': DateTime.now().add(const Duration(days: 7)),
            'status': 'pending',
            'difficulty': 'easy',
          },
        ],
        courses: [
          {
            'id': '1',
            'name': 'Mathematics Grade 10',
            'progress': 70,
            'instructor': 'Ms. Wanjiku',
            'nextLesson': 'Quadratic Equations',
          },
          {
            'id': '2',
            'name': 'Science & Technology',
            'progress': 80,
            'instructor': 'Mr. Kamau',
            'nextLesson': 'Photosynthesis',
          },
          {
            'id': '3',
            'name': 'Computer Studies',
            'progress': 75,
            'instructor': 'Ms. Achieng',
            'nextLesson': 'Loops in Programming',
          },
        ],
      );

      _setLoading(false);
    } catch (e) {
      _setError('Failed to load student dashboard: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Load teacher dashboard data
  Future<void> loadTeacherDashboard(String teacherId) async {
    _setLoading(true);
    _setError(null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      _teacherData = DashboardData(
        stats: {
          'totalStudents': 120,
          'totalClasses': 8,
          'averagePerformance': 78.5,
          'pendingGrading': 15,
          'upcomingClasses': 3,
          'satisfaction': 4.2,
        },
        recentActivity: [
          {
            'type': 'assignment_graded',
            'title': 'Graded Mathematics Quiz for Grade 10A',
            'count': 25,
            'date': DateTime.now().subtract(const Duration(hours: 1)),
          },
          {
            'type': 'class_completed',
            'title': 'Algebra Basics - Grade 10B',
            'duration': 45,
            'date': DateTime.now().subtract(const Duration(hours: 3)),
          },
          {
            'type': 'student_question',
            'title': 'Question from Brian O. about quadratic equations',
            'date': DateTime.now().subtract(const Duration(hours: 4)),
          },
        ],
        assignments: [
          {
            'id': '1',
            'title': 'Grade 10A - Weekly Quiz',
            'subject': 'Mathematics',
            'dueDate': DateTime.now().add(const Duration(days: 2)),
            'status': 'pending_review',
            'submissionCount': 22,
            'totalStudents': 25,
          },
          {
            'id': '2',
            'title': 'Grade 11 - Science Project',
            'subject': 'Science',
            'dueDate': DateTime.now().add(const Duration(days: 10)),
            'status': 'active',
            'submissionCount': 5,
            'totalStudents': 30,
          },
        ],
        courses: [
          {
            'id': '1',
            'name': 'Mathematics Grade 10A',
            'students': 25,
            'progress': 65,
            'nextClass': DateTime.now().add(const Duration(hours: 24)),
          },
          {
            'id': '2',
            'name': 'Mathematics Grade 10B',
            'students': 28,
            'progress': 60,
            'nextClass': DateTime.now().add(const Duration(hours: 26)),
          },
          {
            'id': '3',
            'name': 'Advanced Mathematics Grade 11',
            'students': 22,
            'progress': 45,
            'nextClass': DateTime.now().add(const Duration(hours: 48)),
          },
        ],
      );

      _setLoading(false);
    } catch (e) {
      _setError('Failed to load teacher dashboard: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Load parent dashboard data
  Future<void> loadParentDashboard(String parentId) async {
    _setLoading(true);
    _setError(null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      _parentData = DashboardData(
        stats: {
          'totalChildren': 2,
          'averagePerformance': 82.0,
          'totalAssignments': 12,
          'completedAssignments': 9,
          'upcomingEvents': 4,
          'monthlyProgress': '+5.2%',
        },
        recentActivity: [
          {
            'type': 'assignment_completed',
            'child': 'Sarah Wanjiku',
            'title': 'Completed Mathematics Quiz',
            'score': 88,
            'date': DateTime.now().subtract(const Duration(hours: 2)),
          },
          {
            'type': 'teacher_message',
            'child': 'John Wanjiku',
            'title': 'Message from Ms. Achieng about improved performance',
            'date': DateTime.now().subtract(const Duration(hours: 6)),
          },
          {
            'type': 'achievement',
            'child': 'Sarah Wanjiku',
            'title': 'Earned "Science Explorer" badge',
            'date': DateTime.now().subtract(const Duration(days: 1)),
          },
        ],
        assignments: [
          {
            'id': '1',
            'child': 'Sarah Wanjiku',
            'title': 'Science Project',
            'subject': 'Science',
            'dueDate': DateTime.now().add(const Duration(days: 3)),
            'status': 'in_progress',
            'teacher': 'Mr. Kamau',
          },
          {
            'id': '2',
            'child': 'John Wanjiku',
            'title': 'Essay Writing',
            'subject': 'Languages',
            'dueDate': DateTime.now().add(const Duration(days: 5)),
            'status': 'pending',
            'teacher': 'Ms. Njeri',
          },
        ],
        courses: [
          {
            'child': 'Sarah Wanjiku',
            'courses': [
              {
                'name': 'Mathematics Grade 8',
                'progress': 75,
                'grade': 'A-',
                'teacher': 'Ms. Wanjiku',
              },
              {
                'name': 'Science Grade 8',
                'progress': 82,
                'grade': 'A',
                'teacher': 'Mr. Kamau',
              },
            ],
          },
          {
            'child': 'John Wanjiku',
            'courses': [
              {
                'name': 'Mathematics Grade 6',
                'progress': 68,
                'grade': 'B+',
                'teacher': 'Ms. Achieng',
              },
              {
                'name': 'Languages Grade 6',
                'progress': 85,
                'grade': 'A',
                'teacher': 'Ms. Njeri',
              },
            ],
          },
        ],
      );

      _setLoading(false);
    } catch (e) {
      _setError('Failed to load parent dashboard: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Refresh data
  Future<void> refreshDashboard(String userType, String userId) async {
    switch (userType) {
      case 'student':
        await loadStudentDashboard(userId);
        break;
      case 'teacher':
        await loadTeacherDashboard(userId);
        break;
      case 'parent':
        await loadParentDashboard(userId);
        break;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
