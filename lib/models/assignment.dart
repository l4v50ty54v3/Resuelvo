enum AssignmentStatus {
  draft,
  published,
  submitted,
  graded,
  overdue,
}

class Assignment {
  final String id;
  final String classId;
  final String teacherId;
  final String title;
  final String description;
  final String? attachmentUrl;
  final DateTime dueDate;
  final int maxPoints;
  final AssignmentStatus status;
  final List<String> submittedStudentIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Assignment({
    required this.id,
    required this.classId,
    required this.teacherId,
    required this.title,
    required this.description,
    this.attachmentUrl,
    required this.dueDate,
    required this.maxPoints,
    required this.status,
    required this.submittedStudentIds,
    required this.createdAt,
    this.updatedAt,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      classId: json['classId'] as String,
      teacherId: json['teacherId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      attachmentUrl: json['attachmentUrl'] as String?,
      dueDate: DateTime.parse(json['dueDate'] as String),
      maxPoints: json['maxPoints'] as int,
      status: AssignmentStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => AssignmentStatus.draft,
      ),
      submittedStudentIds: List<String>.from(json['submittedStudentIds'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'teacherId': teacherId,
      'title': title,
      'description': description,
      'attachmentUrl': attachmentUrl,
      'dueDate': dueDate.toIso8601String(),
      'maxPoints': maxPoints,
      'status': status.name,
      'submittedStudentIds': submittedStudentIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Assignment copyWith({
    String? id,
    String? classId,
    String? teacherId,
    String? title,
    String? description,
    String? attachmentUrl,
    DateTime? dueDate,
    int? maxPoints,
    AssignmentStatus? status,
    List<String>? submittedStudentIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Assignment(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      teacherId: teacherId ?? this.teacherId,
      title: title ?? this.title,
      description: description ?? this.description,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      dueDate: dueDate ?? this.dueDate,
      maxPoints: maxPoints ?? this.maxPoints,
      status: status ?? this.status,
      submittedStudentIds: submittedStudentIds ?? this.submittedStudentIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}