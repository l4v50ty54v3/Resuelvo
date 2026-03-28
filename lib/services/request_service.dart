import '../models/parse_request.dart';
import '../models/request.dart';

class RequestService {
  // Crear una nueva solicitud
  static Future<ParseRequest?> createRequest({
    required String studentId,
    required String teacherId,
    String? classId,
    required ParseRequestType type,
    required String title,
    required String description,
  }) async {
    final request = ParseRequest()
      ..studentId = studentId
      ..teacherId = teacherId
      ..classId = classId
      ..type = type
      ..title = title
      ..description = description
      ..status = ParseRequestStatus.pending;

    final success = await request.saveRequest();
    return success ? request : null;
  }

  // Obtener todas las solicitudes
  static Future<List<ParseRequest>> getAllRequests() async {
    return await ParseRequest.getAllRequests();
  }

  // Obtener solicitudes por profesor
  static Future<List<ParseRequest>> getRequestsByTeacher(String teacherId) async {
    return await ParseRequest.getByTeacher(teacherId);
  }

  // Obtener solicitudes por estudiante
  static Future<List<ParseRequest>> getRequestsByStudent(String studentId) async {
    return await ParseRequest.getByStudent(studentId);
  }

  // Obtener solicitudes pendientes de un profesor
  static Future<List<ParseRequest>> getPendingRequests(String teacherId) async {
    return await ParseRequest.getPendingRequests(teacherId);
  }

  // Obtener solicitud por ID
  static Future<ParseRequest?> getRequestById(String requestId) async {
    return await ParseRequest.getById(requestId);
  }

  // Marcar solicitud como en progreso
  static Future<bool> markRequestInProgress(String requestId) async {
    final request = await getRequestById(requestId);
    if (request != null) {
      return await request.markAsInProgress();
    }
    return false;
  }

  // Completar solicitud
  static Future<bool> completeRequest(String requestId, {String? response}) async {
    final request = await getRequestById(requestId);
    if (request != null) {
      return await request.markAsCompleted(responseText: response);
    }
    return false;
  }

  // Cancelar solicitud
  static Future<bool> cancelRequest(String requestId) async {
    final request = await getRequestById(requestId);
    if (request != null) {
      return await request.cancel();
    }
    return false;
  }

  // Actualizar solicitud
  static Future<bool> updateRequest(ParseRequest request) async {
    return await request.saveRequest();
  }

  // Eliminar solicitud
  static Future<bool> deleteRequest(String requestId) async {
    final request = await getRequestById(requestId);
    if (request != null) {
      return await request.deleteRequest();
    }
    return false;
  }

  // Obtener estadísticas de solicitudes por profesor
  static Future<Map<String, int>> getRequestStats(String teacherId) async {
    final allRequests = await getRequestsByTeacher(teacherId);

    return {
      'total': allRequests.length,
      'pending': allRequests.where((r) => r.status == ParseRequestStatus.pending).length,
      'inProgress': allRequests.where((r) => r.status == ParseRequestStatus.inProgress).length,
      'completed': allRequests.where((r) => r.status == ParseRequestStatus.completed).length,
      'cancelled': allRequests.where((r) => r.status == ParseRequestStatus.cancelled).length,
    };
  }
}