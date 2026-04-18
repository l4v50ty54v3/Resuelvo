import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/parse_user_model.dart';
import '../models/parse_teacher.dart';
import '../models/parse_student.dart';

class AuthService {
  // Login con email y password
  static Future<ParseUser?> login(String email, String password) async {
    final user = ParseUser(email, password, null);
    final response = await user.login();

    if (response.success) {
      return response.result as ParseUser;
    } else {
      throw Exception('Error al iniciar sesión: ${response.error?.message}');
    }
  }

  // Registro de usuario
  static Future<ParseUser?> register({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    final user = ParseUser(username, password, email)
      ..set('role', role);

    final response = await user.signUp();

    if (response.success) {
      return response.result as ParseUser;
    } else {
      throw Exception('Error al registrar usuario: ${response.error?.message}');
    }
  }

  // Logout
  static Future<void> logout() async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
    }
  }

  // Obtener usuario actual
  static Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser();
  }

  // Verificar si hay usuario logueado
  static Future<bool> isUserLoggedIn() async {
    final user = await ParseUser.currentUser();
    return user != null;
  }

  // Crear perfil de profesor
  static Future<ParseTeacher?> createTeacherProfile({
    required String userId,
    required String subject,
    String? bio,
    String? specialization,
    int yearsOfExperience = 0,
  }) async {
    final teacher = ParseTeacher()
      ..user = ParseUser.forQuery()..objectId = userId
      ..subject = subject
      ..bio = bio
      ..specialization = specialization
      ..yearsOfExperience = yearsOfExperience
      ..rating = 0.0
      ..totalStudents = 0
      ..totalHours = 0
      ..classIds = [];

    final success = await teacher.saveTeacher();
    return success ? teacher : null;
  }

  // Crear perfil de estudiante
  static Future<ParseStudent?> createStudentProfile({
    required String userId,
    required String grade,
    String? school,
  }) async {
    final student = ParseStudent()
      ..user = ParseUser.forQuery()..objectId = userId
      ..grade = grade
      ..school = school
      ..enrolledClassIds = []
      ..completedClassIds = [];

    final success = await student.saveStudent();
    return success ? student : null;
  }

  // Obtener perfil de profesor por userId
  static Future<ParseTeacher?> getTeacherProfile(String userId) async {
    final query = QueryBuilder<ParseTeacher>(ParseTeacher())
      ..whereEqualTo('user', ParseUser.forQuery()..objectId = userId)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null && response.results!.isNotEmpty) {
      return response.results!.first as ParseTeacher;
    }
    return null;
  }

  // Obtener perfil de estudiante por userId
  static Future<ParseStudent?> getStudentProfile(String userId) async {
    final query = QueryBuilder<ParseStudent>(ParseStudent())
      ..whereEqualTo('user', ParseUser.forQuery()..objectId = userId)
      ..includeObject(['user']);

    final response = await query.query();
    if (response.success && response.results != null && response.results!.isNotEmpty) {
      return response.results!.first as ParseStudent;
    }
    return null;
  }

  // Reset password
  static Future<bool> resetPassword(String email) async {
    final user = ParseUser(null, null, null)..emailAddress = email;
    final response = await user.requestPasswordReset();

    return response.success;
  }
}