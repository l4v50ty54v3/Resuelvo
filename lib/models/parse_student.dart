import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'base_model.dart';
import 'parse_user_model.dart';

class ParseStudent extends BaseModel {
  ParseStudent() : super('Student');

  ParseStudent.clone() : this();

  // Getters
  ParseUser? get user => get<ParseUser>('user');
  String get grade => get<String>('grade') ?? '';
  String? get school => get<String>('school');
  List<String> get enrolledClassIds => get<List<dynamic>>('enrolledClassIds')?.cast<String>() ?? [];
  List<String> get completedClassIds => get<List<dynamic>>('completedClassIds')?.cast<String>() ?? [];

  // Setters
  set user(ParseUser? value) => set<ParseUser?>('user', value);
  set grade(String value) => set<String>('grade', value);
  set school(String? value) => set<String?>('school', value);
  set enrolledClassIds(List<String> value) => set<List<String>>('enrolledClassIds', value);
  set completedClassIds(List<String> value) => set<List<String>>('completedClassIds', value);

  // Factory methods
  static Future<ParseStudent?> getById(String id) async {
    final query = QueryBuilder<ParseStudent>(ParseStudent())
      ..whereEqualTo('objectId', id)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.first as ParseStudent;
    }
    return null;
  }

  static Future<List<ParseStudent>> getAllStudents() async {
    final query = QueryBuilder<ParseStudent>(ParseStudent())
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseStudent>();
    }
    return [];
  }

  static Future<List<ParseStudent>> getByGrade(String grade) async {
    final query = QueryBuilder<ParseStudent>(ParseStudent())
      ..whereEqualTo('grade', grade)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseStudent>();
    }
    return [];
  }

  // CRUD operations
  Future<bool> saveStudent() async {
    setTimestamps();
    final response = await save();
    return response.success;
  }

  Future<bool> deleteStudent() async {
    final response = await delete();
    return response.success;
  }

  // Helper methods
  Future<bool> enrollInClass(String classId) async {
    if (!enrolledClassIds.contains(classId)) {
      enrolledClassIds.add(classId);
      return await saveStudent();
    }
    return true;
  }

  Future<bool> completeClass(String classId) async {
    if (enrolledClassIds.contains(classId) && !completedClassIds.contains(classId)) {
      enrolledClassIds.remove(classId);
      completedClassIds.add(classId);
      return await saveStudent();
    }
    return true;
  }
}