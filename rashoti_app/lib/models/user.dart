enum UserType { student, teacher, parent }

class User {
  final String id;
  final String email;
  final String name;
  final UserType type;
  final String? profileImage;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
    this.profileImage,
    required this.createdAt,
    this.metadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      type: UserType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => UserType.student,
      ),
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'type': type.name,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    UserType? type,
    String? profileImage,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      type: type ?? this.type,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

class Student extends User {
  final String grade;
  final List<String> subjects;
  final String? parentId;
  final String? schoolId;

  Student({
    required super.id,
    required super.email,
    required super.name,
    super.profileImage,
    required super.createdAt,
    super.metadata,
    required this.grade,
    required this.subjects,
    this.parentId,
    this.schoolId,
  }) : super(type: UserType.student);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      metadata: json['metadata'],
      grade: json['grade'],
      subjects: List<String>.from(json['subjects'] ?? []),
      parentId: json['parent_id'],
      schoolId: json['school_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'grade': grade,
      'subjects': subjects,
      'parent_id': parentId,
      'school_id': schoolId,
    });
    return baseJson;
  }
}

class Teacher extends User {
  final List<String> subjects;
  final List<String> grades;
  final String? schoolId;
  final String department;

  Teacher({
    required super.id,
    required super.email,
    required super.name,
    super.profileImage,
    required super.createdAt,
    super.metadata,
    required this.subjects,
    required this.grades,
    this.schoolId,
    required this.department,
  }) : super(type: UserType.teacher);

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      metadata: json['metadata'],
      subjects: List<String>.from(json['subjects'] ?? []),
      grades: List<String>.from(json['grades'] ?? []),
      schoolId: json['school_id'],
      department: json['department'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'subjects': subjects,
      'grades': grades,
      'school_id': schoolId,
      'department': department,
    });
    return baseJson;
  }
}

class Parent extends User {
  final List<String> childrenIds;
  final String? occupation;

  Parent({
    required super.id,
    required super.email,
    required super.name,
    super.profileImage,
    required super.createdAt,
    super.metadata,
    required this.childrenIds,
    this.occupation,
  }) : super(type: UserType.parent);

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      metadata: json['metadata'],
      childrenIds: List<String>.from(json['children_ids'] ?? []),
      occupation: json['occupation'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    baseJson.addAll({
      'children_ids': childrenIds,
      'occupation': occupation,
    });
    return baseJson;
  }
}
