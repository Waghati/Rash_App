class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://localhost:8080/api'; // Your Rust backend
  static const String moodleUrl = 'YOUR_MOODLE_URL'; // Add your Moodle URL
  static const String pesapalUrl = 'https://cybqa.pesapal.com/pesapalv3'; // PesaPal sandbox

  // App Information
  static const String appName = 'Rashoti';
  static const String appTagline = 'Smarter Learning, Powered by AI';
  static const String appDescription = 'Personalized, engaging, and curriculum-aligned education for students, teachers, and parents — all in one futuristic platform.';

  // Contact Information
  static const String contactEmail = 'info@rashoti.com';
  static const String contactPhone = '+ (314) 459-1663';
  static const String website = 'www.rashoti.com';
  static const String location = 'Kenya & United States';

  // Pricing Plans
  static const Map<String, dynamic> pricingPlans = {
    'free': {
      'name': 'Free Plan',
      'price': 'Ksh.0',
      'period': 'Month',
      'features': [
        'Access to 3 Subjects',
        'Limited Practice Quizzes',
        'AI Study Suggestions (Basics)',
      ],
      'limitations': [
        'No Parent/Teacher Dashboard',
        'Offline Downloads',
      ],
    },
    'standard': {
      'name': 'Standard Plan',
      'price': 'Ksh.500',
      'period': 'Month',
      'features': [
        'All Subjects (Grade 1-12)',
        'Personal Quizzes & AI Feedback',
        'Parent + Teacher Dashboard',
        'Offline Downloads',
      ],
      'limitations': [
        'Real-time Classroom Chat',
      ],
    },
    'premium': {
      'name': 'Premium Plan',
      'price': 'Ksh.999',
      'period': 'Month',
      'features': [
        'Everything in Standard Plan',
        'Virtual Classrooms',
        'Priority Support',
        'Early Access to New Modules',
        'School-wide Licensing Options',
      ],
      'limitations': [],
    },
  };

  // Subject Information
  static const Map<String, dynamic> subjects = {
    'mathematics': {
      'name': 'Mathematics',
      'grade': 'Grade 1 - 12',
      'progress': 70,
      'icon': '🧮',
    },
    'science': {
      'name': 'Science & Tech',
      'grade': 'Grade 1 - 12',
      'progress': 80,
      'icon': '🔬',
    },
    'languages': {
      'name': 'Languages',
      'grade': 'Grade 1 - 12',
      'progress': 60,
      'icon': '📚',
    },
    'computer': {
      'name': 'Computer Studies',
      'grade': 'Grade 4 - 12',
      'progress': 75,
      'icon': '💻',
    },
    'lifeSkills': {
      'name': 'Life Skills',
      'grade': 'Grade 1 - 9',
      'progress': 40,
      'icon': '🌟',
    },
  };

  // Testimonials
  static const List<Map<String, dynamic>> testimonials = [
    {
      'name': 'MS. Wanjiku M.',
      'role': 'Junior Secondary Teacher - Nairobi',
      'message': 'With Rashoti AI-powered dashboard, I can instantly see where student is struggling, its transform how I teach and engage.',
      'rating': 4,
      'image': 'assets/images/teacher1.jpg',
    },
    {
      'name': 'Margaret N.',
      'role': 'Parent - Nakuru',
      'message': 'My daughter no longer dreads doing homework. The Lessons are interactive, and I can finally track her progress.',
      'rating': 4,
      'image': 'assets/images/parent1.jpg',
    },
    {
      'name': 'Brian Otieno',
      'role': 'Grade 12 student - Kisumu',
      'message': 'Rashoti made learning feel like a game. I went from struggling with science to being top of my class and I actually I enjoy studying now.',
      'rating': 5,
      'image': 'assets/images/student1.jpg',
    },
    {
      'name': 'Mr. Limo',
      'role': 'Deputy Principal - Eldoret',
      'message': 'Rashoti aligns perfectly with CBC. It\'s the first platform that truly supports competency-based learning in a structured and a measurable way.',
      'rating': 4,
      'image': 'assets/images/principal1.jpg',
    },
  ];

  // Navigation Routes
  static const String landingRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String studentDashboardRoute = '/student-dashboard';
  static const String teacherDashboardRoute = '/teacher-dashboard';
  static const String parentDashboardRoute = '/parent-dashboard';

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userTypeKey = 'user_type';
  static const String userDataKey = 'user_data';
}