import '../models/parse_class.dart';
import '../models/parse_teacher.dart';
import '../models/parse_student.dart';

class ClassService {
  // Crear una nueva clase
  static Future<ParseClass?> createClass({
    required String name,
    required String subject,
    required String teacherId,
    required String description,
    required String schedule,
    required int maxStudents,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final newClass = ParseClass()
      ..name = name
      ..subject = subject
      ..teacherId = teacherId
      ..description = description
      ..schedule = schedule
      ..maxStudents = maxStudents
      ..currentStudents = 0
      ..status = ParseClassStatus.active
      ..studentIds = []
      ..startDate = startDate
      ..endDate = endDate;

    final success = await newClass.saveClass();
    return success ? newClass : null;
  }

  // Obtener todas las clases
  static Future<List<ParseClass>> getAllClasses() async {
    return await ParseClass.getAllClasses();
  }

  // Obtener clases por profesor
  static Future<List<ParseClass>> getClassesByTeacher(String teacherId) async {
    return await ParseClass.getByTeacher(teacherId);
  }

  // Obtener clases por materia
  static Future<List<ParseClass>> getClassesBySubject(String subject) async {
    return await ParseClass.getBySubject(subject);
  }

  // Obtener clases activas
  static Future<List<ParseClass>> getActiveClasses() async {
    return await ParseClass.getActiveClasses();
  }

  // Obtener clase por ID
  static Future<ParseClass?> getClassById(String classId) async {
    return await ParseClass.getById(classId);
  }

  // Inscribir estudiante en clase
  static Future<bool> enrollStudent(String classId, String studentId) async {
    final classObj = await getClassById(classId);
    if (classObj != null) {
      return await classObj.enrollStudent(studentId);
    }
    return false;
  }

  // Desinscribir estudiante de clase
  static Future<bool> unenrollStudent(String classId, String studentId) async {
    final classObj = await getClassById(classId);
    if (classObj != null) {
      return await classObj.unenrollStudent(studentId);
    }
    return false;
  }

  // Actualizar clase
  static Future<bool> updateClass(ParseClass classObj) async {
    return await classObj.saveClass();
  }

  // Eliminar clase
  static Future<bool> deleteClass(String classId) async {
    final classObj = await getClassById(classId);
    if (classObj != null) {
      return await classObj.deleteClass();
    }
    return false;
  }

  // Verificar si estudiante está inscrito en clase
  static Future<bool> isStudentEnrolled(String classId, String studentId) async {
    final classObj = await getClassById(classId);
    return classObj?.studentIds.contains(studentId) ?? false;
  }

  // Obtener clases de un estudiante
  static Future<List<ParseClass>> getStudentClasses(String studentId) async {
    final allClasses = await getAllClasses();
    return allClasses.where((classObj) => classObj.studentIds.contains(studentId)).toList();
  }
}