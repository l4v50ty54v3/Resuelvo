import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'base_model.dart';

enum ParseUserRole {
  student,
  teacher,
  admin,
}

class ParseUserModel extends BaseModel {
  ParseUserModel() : super('User');

  ParseUserModel.clone() : this();

  // Getters
  String get name => get<String>('name') ?? '';
  String get email => get<String>('email') ?? '';
  String? get phone => get<String>('phone');
  ParseUserRole get role => ParseUserRole.values.firstWhere(
        (r) => r.name == get<String>('role'),
        orElse: () => ParseUserRole.student,
      );
  String? get profileImageUrl => get<String>('profileImageUrl');

  // Setters
  set name(String value) => set<String>('name', value);
  set email(String value) => set<String>('email', value);
  set phone(String? value) => set<String?>('phone', value);
  set role(ParseUserRole value) => set<String>('role', value.name);
  set profileImageUrl(String? value) => set<String?>('profileImageUrl', value);

  // Factory methods
  static Future<ParseUserModel?> getById(String id) async {
    final query = QueryBuilder<ParseUserModel>(ParseUserModel())
      ..whereEqualTo('objectId', id);

    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.first as ParseUserModel;
    }
    return null;
  }

  static Future<List<ParseUserModel>> getAllUsers() async {
    final query = QueryBuilder<ParseUserModel>(ParseUserModel());
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results!.cast<ParseUserModel>();
    }
    return [];
  }

  // CRUD operations
  Future<bool> saveUser() async {
    setTimestamps();
    final response = await save();
    return response.success;
  }

  Future<bool> deleteUser() async {
    final response = await delete();
    return response.success;
  }
}