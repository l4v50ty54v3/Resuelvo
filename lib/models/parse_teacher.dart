import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'base_model.dart';
import 'parse_user_model.dart';

class ParseTeacher extends BaseModel {
  ParseTeacher() : super('Teacher');

  ParseTeacher.clone() : this();

  // Getters
  ParseUserModel? get user => get<ParseUserModel>('user');
  String get subject => get<String>('subject') ?? '';
  String? get bio => get<String>('bio');
  String? get specialization => get<String>('specialization');
  int get yearsOfExperience => get<int>('yearsOfExperience') ?? 0;
  double get rating => get<double>('rating') ?? 0.0;
  int get totalStudents => get<int>('totalStudents') ?? 0;
  int get totalHours => get<int>('totalHours') ?? 0;
  List<String> get classIds => get<List<dynamic>>('classIds')?.cast<String>() ?? [];

  // Setters
  set user(ParseUserModel? value) => set<ParseUserModel?>('user', value);
  set subject(String value) => set<String>('subject', value);
  set bio(String? value) => set<String?>('bio', value);
  set specialization(String? value) => set<String?>('specialization', value);
  set yearsOfExperience(int value) => set<int>('yearsOfExperience', value);
  set rating(double value) => set<double>('rating', value);
  set totalStudents(int value) => set<int>('totalStudents', value);
  set totalHours(int value) => set<int>('totalHours', value);
  set classIds(List<String> value) => set<List<String>>('classIds', value);

  // Factory methods
  static Future<ParseTeacher?> getById(String id) async {
    final query = QueryBuilder<ParseTeacher>(ParseTeacher())
      ..whereEqualTo('objectId', id)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.first as ParseTeacher;
    }
    return null;
  }

  static Future<List<ParseTeacher>> getAllTeachers() async {
    final query = QueryBuilder<ParseTeacher>(ParseTeacher())
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseTeacher>();
    }
    return [];
  }

  static Future<List<ParseTeacher>> getBySubject(String subject) async {
    final query = QueryBuilder<ParseTeacher>(ParseTeacher())
      ..whereEqualTo('subject', subject)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseTeacher>();
    }
    return [];
  }

  // CRUD operations
  Future<bool> saveTeacher() async {
    setTimestamps();
    final response = await save();
    return response.success;
  }

  Future<bool> deleteTeacher() async {
    final response = await delete();
    return response.success;
  }
}