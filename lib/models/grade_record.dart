class GradeRecord {
  final String id;
  final String studentId;
  final String assignmentId;
  final String classId;
  final double points;
  final double maxPoints;
  final String? feedback;
  final DateTime gradedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const GradeRecord({
    required this.id,
    required this.studentId,
    required this.assignmentId,
    required this.classId,
    required this.points,
    required this.maxPoints,
    this.feedback,
    required this.gradedAt,
    required this.createdAt,
    this.updatedAt,
  });

  double get percentage => (points / maxPoints) * 100;

  String get letterGrade {
    final percent = percentage;
    if (percent >= 90) return 'A';
    if (percent >= 80) return 'B';
    if (percent >= 70) return 'C';
    if (percent >= 60) return 'D';
    return 'F';
  }

  factory GradeRecord.fromJson(Map<String, dynamic> json) {
    return GradeRecord(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      assignmentId: json['assignmentId'] as String,
      classId: json['classId'] as String,
      points: (json['points'] as num).toDouble(),
      maxPoints: (json['maxPoints'] as num).toDouble(),
      feedback: json['feedback'] as String?,
      gradedAt: DateTime.parse(json['gradedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'assignmentId': assignmentId,
      'classId': classId,
      'points': points,
      'maxPoints': maxPoints,
      'feedback': feedback,
      'gradedAt': gradedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  GradeRecord copyWith({
    String? id,
    String? studentId,
    String? assignmentId,
    String? classId,
    double? points,
    double? maxPoints,
    String? feedback,
    DateTime? gradedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GradeRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      assignmentId: assignmentId ?? this.assignmentId,
      classId: classId ?? this.classId,
      points: points ?? this.points,
      maxPoints: maxPoints ?? this.maxPoints,
      feedback: feedback ?? this.feedback,
      gradedAt: gradedAt ?? this.gradedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}