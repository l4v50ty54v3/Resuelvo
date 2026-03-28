import 'user.dart';

class Student {
  final String id;
  final User user;
  final String grade;
  final String? school;
  final List<String> enrolledClassIds;
  final List<String> completedClassIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Student({
    required this.id,
    required this.user,
    required this.grade,
    this.school,
    required this.enrolledClassIds,
    required this.completedClassIds,
    required this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      grade: json['grade'] as String,
      school: json['school'] as String?,
      enrolledClassIds: List<String>.from(json['enrolledClassIds'] as List),
      completedClassIds: List<String>.from(json['completedClassIds'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'grade': grade,
      'school': school,
      'enrolledClassIds': enrolledClassIds,
      'completedClassIds': completedClassIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Student copyWith({
    String? id,
    User? user,
    String? grade,
    String? school,
    List<String>? enrolledClassIds,
    List<String>? completedClassIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      user: user ?? this.user,
      grade: grade ?? this.grade,
      school: school ?? this.school,
      enrolledClassIds: enrolledClassIds ?? this.enrolledClassIds,
      completedClassIds: completedClassIds ?? this.completedClassIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}