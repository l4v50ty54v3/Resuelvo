enum ClassStatus {
  active,
  completed,
  cancelled,
}

class ClassModel {
  final String id;
  final String name;
  final String subject;
  final String teacherId;
  final String description;
  final String schedule;
  final int maxStudents;
  final int currentStudents;
  final ClassStatus status;
  final List<String> studentIds;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.teacherId,
    required this.description,
    required this.schedule,
    required this.maxStudents,
    required this.currentStudents,
    required this.status,
    required this.studentIds,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    this.updatedAt,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      teacherId: json['teacherId'] as String,
      description: json['description'] as String,
      schedule: json['schedule'] as String,
      maxStudents: json['maxStudents'] as int,
      currentStudents: json['currentStudents'] as int,
      status: ClassStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => ClassStatus.active,
      ),
      studentIds: List<String>.from(json['studentIds'] as List),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'teacherId': teacherId,
      'description': description,
      'schedule': schedule,
      'maxStudents': maxStudents,
      'currentStudents': currentStudents,
      'status': status.name,
      'studentIds': studentIds,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  ClassModel copyWith({
    String? id,
    String? name,
    String? subject,
    String? teacherId,
    String? description,
    String? schedule,
    int? maxStudents,
    int? currentStudents,
    ClassStatus? status,
    List<String>? studentIds,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      teacherId: teacherId ?? this.teacherId,
      description: description ?? this.description,
      schedule: schedule ?? this.schedule,
      maxStudents: maxStudents ?? this.maxStudents,
      currentStudents: currentStudents ?? this.currentStudents,
      status: status ?? this.status,
      studentIds: studentIds ?? this.studentIds,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}