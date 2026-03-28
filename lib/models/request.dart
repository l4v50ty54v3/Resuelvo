enum RequestType {
  help,
  consultation,
  material,
  gradeReview,
  other,
}

enum RequestStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

class Request {
  final String id;
  final String studentId;
  final String teacherId;
  final String? classId;
  final RequestType type;
  final String title;
  final String description;
  final RequestStatus status;
  final String? response;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;

  const Request({
    required this.id,
    required this.studentId,
    required this.teacherId,
    this.classId,
    required this.type,
    required this.title,
    required this.description,
    required this.status,
    this.response,
    required this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      teacherId: json['teacherId'] as String,
      classId: json['classId'] as String?,
      type: RequestType.values.firstWhere(
        (type) => type.name == json['type'],
        orElse: () => RequestType.help,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      status: RequestStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      response: json['response'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'teacherId': teacherId,
      'classId': classId,
      'type': type.name,
      'title': title,
      'description': description,
      'status': status.name,
      'response': response,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  Request copyWith({
    String? id,
    String? studentId,
    String? teacherId,
    String? classId,
    RequestType? type,
    String? title,
    String? description,
    RequestStatus? status,
    String? response,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    return Request(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      teacherId: teacherId ?? this.teacherId,
      classId: classId ?? this.classId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}