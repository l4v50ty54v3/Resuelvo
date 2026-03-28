import 'user.dart';

class Teacher {
  final String id;
  final User user;
  final String subject;
  final String? bio;
  final String? specialization;
  final int yearsOfExperience;
  final double rating;
  final int totalStudents;
  final int totalHours;
  final List<String> classIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Teacher({
    required this.id,
    required this.user,
    required this.subject,
    this.bio,
    this.specialization,
    required this.yearsOfExperience,
    required this.rating,
    required this.totalStudents,
    required this.totalHours,
    required this.classIds,
    required this.createdAt,
    this.updatedAt,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      subject: json['subject'] as String,
      bio: json['bio'] as String?,
      specialization: json['specialization'] as String?,
      yearsOfExperience: json['yearsOfExperience'] as int,
      rating: (json['rating'] as num).toDouble(),
      totalStudents: json['totalStudents'] as int,
      totalHours: json['totalHours'] as int,
      classIds: List<String>.from(json['classIds'] as List),
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
      'subject': subject,
      'bio': bio,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'totalStudents': totalStudents,
      'totalHours': totalHours,
      'classIds': classIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Teacher copyWith({
    String? id,
    User? user,
    String? subject,
    String? bio,
    String? specialization,
    int? yearsOfExperience,
    double? rating,
    int? totalStudents,
    int? totalHours,
    List<String>? classIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Teacher(
      id: id ?? this.id,
      user: user ?? this.user,
      subject: subject ?? this.subject,
      bio: bio ?? this.bio,
      specialization: specialization ?? this.specialization,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      rating: rating ?? this.rating,
      totalStudents: totalStudents ?? this.totalStudents,
      totalHours: totalHours ?? this.totalHours,
      classIds: classIds ?? this.classIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}