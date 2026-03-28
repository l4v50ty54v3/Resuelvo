import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'base_model.dart';

enum ParseClassStatus {
  active,
  completed,
  cancelled,
}

class ParseClass extends BaseModel {
  ParseClass() : super('Class');

  ParseClass.clone() : this();

  // Getters
  String get name => get<String>('name') ?? '';
  String get subject => get<String>('subject') ?? '';
  String get teacherId => get<String>('teacherId') ?? '';
  String get description => get<String>('description') ?? '';
  String get schedule => get<String>('schedule') ?? '';
  int get maxStudents => get<int>('maxStudents') ?? 0;
  int get currentStudents => get<int>('currentStudents') ?? 0;
  ParseClassStatus get status => ParseClassStatus.values.firstWhere(
        (s) => s.name == get<String>('status'),
        orElse: () => ParseClassStatus.active,
      );
  List<String> get studentIds => get<List<dynamic>>('studentIds')?.cast<String>() ?? [];
  DateTime? get startDate => get<DateTime>('startDate');
  DateTime? get endDate => get<DateTime>('endDate');

  // Setters
  set name(String value) => set<String>('name', value);
  set subject(String value) => set<String>('subject', value);
  set teacherId(String value) => set<String>('teacherId', value);
  set description(String value) => set<String>('description', value);
  set schedule(String value) => set<String>('schedule', value);
  set maxStudents(int value) => set<int>('maxStudents', value);
  set currentStudents(int value) => set<int>('currentStudents', value);
  set status(ParseClassStatus value) => set<String>('status', value.name);
  set studentIds(List<String> value) => set<List<String>>('studentIds', value);
  set startDate(DateTime? value) => set<DateTime?>('startDate', value);
  set endDate(DateTime? value) => set<DateTime?>('endDate', value);

  // Factory methods
  static Future<ParseClass?> getById(String id) async {
    final query = QueryBuilder<ParseClass>(ParseClass())
      ..whereEqualTo('objectId', id);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.first as ParseClass;
    }
    return null;
  }

  static Future<List<ParseClass>> getAllClasses() async {
    final query = QueryBuilder<ParseClass>(ParseClass());
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<ParseClass>();
    }
    return [];
  }

  static Future<List<ParseClass>> getByTeacher(String teacherId) async {
    final query = QueryBuilder<ParseClass>(ParseClass())
      ..whereEqualTo('teacherId', teacherId);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseClass>();
    }
    return [];
  }

  static Future<List<ParseClass>> getBySubject(String subject) async {
    final query = QueryBuilder<ParseClass>(ParseClass())
      ..whereEqualTo('subject', subject);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseClass>();
    }
    return [];
  }

  static Future<List<ParseClass>> getActiveClasses() async {
    final query = QueryBuilder<ParseClass>(ParseClass())
      ..whereEqualTo('status', ParseClassStatus.active.name);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseClass>();
    }
    return [];
  }

  // CRUD operations
  Future<bool> saveClass() async {
    setTimestamps();
    final response = await save();
    return response.success;
  }

  Future<bool> deleteClass() async {
    final response = await delete();
    return response.success;
  }

  // Helper methods
  bool get isFull => currentStudents >= maxStudents;
  bool get hasAvailableSpots => currentStudents < maxStudents;

  Future<bool> enrollStudent(String studentId) async {
    if (!studentIds.contains(studentId) && hasAvailableSpots) {
      studentIds.add(studentId);
      currentStudents = studentIds.length;
      return await saveClass();
    }
    return false;
  }

  Future<bool> unenrollStudent(String studentId) async {
    if (studentIds.contains(studentId)) {
      studentIds.remove(studentId);
      currentStudents = studentIds.length;
      return await saveClass();
    }
    return false;
  }
}