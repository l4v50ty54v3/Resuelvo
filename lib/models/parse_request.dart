import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'base_model.dart';

enum ParseRequestType {
  help,
  consultation,
  material,
  gradeReview,
  other,
}

enum ParseRequestStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

class ParseRequest extends BaseModel {
  ParseRequest() : super('Request');

  ParseRequest.clone() : this();

  // Getters
  String get studentId => get<String>('studentId') ?? '';
  String get teacherId => get<String>('teacherId') ?? '';
  String? get classId => get<String>('classId');
  ParseRequestType get type => ParseRequestType.values.firstWhere(
        (t) => t.name == get<String>('type'),
        orElse: () => ParseRequestType.help,
      );
  String get title => get<String>('title') ?? '';
  String get description => get<String>('description') ?? '';
  ParseRequestStatus get status => ParseRequestStatus.values.firstWhere(
        (s) => s.name == get<String>('status'),
        orElse: () => ParseRequestStatus.pending,
      );
  String? get response => get<String>('response');
  DateTime? get completedAt => get<DateTime>('completedAt');

  // Setters
  set studentId(String value) => set<String>('studentId', value);
  set teacherId(String value) => set<String>('teacherId', value);
  set classId(String? value) => set<String?>('classId', value);
  set type(ParseRequestType value) => set<String>('type', value.name);
  set title(String value) => set<String>('title', value);
  set description(String value) => set<String>('description', value);
  set status(ParseRequestStatus value) => set<String>('status', value.name);
  set response(String? value) => set<String?>('response', value);
  set completedAt(DateTime? value) => set<DateTime?>('completedAt', value);

  // Factory methods
  static Future<ParseRequest?> getById(String id) async {
    final query = QueryBuilder<ParseRequest>(ParseRequest())
      ..whereEqualTo('objectId', id);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.first as ParseRequest;
    }
    return null;
  }

  static Future<List<ParseRequest>> getAllRequests() async {
    final query = QueryBuilder<ParseRequest>(ParseRequest());
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<ParseRequest>();
    }
    return [];
  }

  static Future<List<ParseRequest>> getByTeacher(String teacherId) async {
    final query = QueryBuilder<ParseRequest>(ParseRequest())
      ..whereEqualTo('teacherId', teacherId)
      ..orderByDescending('createdAt');

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseRequest>();
    }
    return [];
  }

  static Future<List<ParseRequest>> getByStudent(String studentId) async {
    final query = QueryBuilder<ParseRequest>(ParseRequest())
      ..whereEqualTo('studentId', studentId)
      ..orderByDescending('createdAt');

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseRequest>();
    }
    return [];
  }

  static Future<List<ParseRequest>> getPendingRequests(String teacherId) async {
    final query = QueryBuilder<ParseRequest>(ParseRequest())
      ..whereEqualTo('teacherId', teacherId)
      ..whereEqualTo('status', ParseRequestStatus.pending.name)
      ..orderByDescending('createdAt');

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseRequest>();
    }
    return [];
  }

  // CRUD operations
  Future<bool> saveRequest() async {
    setTimestamps();
    final response = await save();
    return response.success;
  }

  Future<bool> deleteRequest() async {
    final response = await delete();
    return response.success;
  }

  // Helper methods
  Future<bool> markAsInProgress() async {
    if (status == ParseRequestStatus.pending) {
      status = ParseRequestStatus.inProgress;
      return await saveRequest();
    }
    return false;
  }

  Future<bool> markAsCompleted({String? responseText}) async {
    status = ParseRequestStatus.completed;
    if (responseText != null) {
      response = responseText;
    }
    completedAt = DateTime.now();
    return await saveRequest();
  }

  Future<bool> cancel() async {
    if (status == ParseRequestStatus.pending || status == ParseRequestStatus.inProgress) {
      status = ParseRequestStatus.cancelled;
      return await saveRequest();
    }
    return false;
  }
}