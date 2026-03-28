import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

abstract class BaseModel extends ParseObject {
  BaseModel(String className) : super(className);

  // Campos comunes
  DateTime get createdAt => this['createdAt'] ?? DateTime.now();
  DateTime? get updatedAt => this['updatedAt'];

  // Método para convertir a Map (útil para debugging)
  Map<String, dynamic> toMap() {
    return toJson();
  }

  // Método para actualizar campos comunes
  void setTimestamps() {
    if (objectId == null) {
      this['createdAt'] = DateTime.now();
    }
    this['updatedAt'] = DateTime.now();
  }
}