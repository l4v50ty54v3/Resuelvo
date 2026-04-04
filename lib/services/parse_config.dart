import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ParseConfig {
  static const String applicationId = "X3CDilgdfLSuHy9RdZ9wvp8Z2Bn6ILBcxRvh1GdX";
  static const String clientKey = "E3VWPCNZJc1RY8tPfdxNvBfe45fwU3nU3v6jmgYa"; // Reemplaza con tu Client Key
  static const String serverUrl = "https://parseapi.back4app.com"; // Reemplaza con tu URL del servidor

  static Future<void> initialize() async {
    const appId = applicationId;
    const serverUrl = ParseConfig.serverUrl;
    const clientKey = ParseConfig.clientKey;
    //const liveQueryUrl = 'https://your-parse-server-url'; // Opcional para live queries
    const debug = true; // Cambia a false en producción

    await Parse().initialize(
      appId,
      serverUrl,
      clientKey: clientKey,
      //liveQueryUrl: liveQueryUrl,
      debug: debug,
      // Opcional: configuración adicional
      // appName: 'Resuelvo',
      // appVersion: '1.0.0',
      // appPackageName: 'com.resuelvo.app',
    );

    // Verificar conexión
    final ParseResponse response = await Parse().healthCheck();
    if (response.success) {
      print('Parse Server conectado correctamente');
    } else {
      print('Error conectando a Parse Server: ${response.error?.message}');
    }
  }

  // Método para verificar si el usuario está logueado
  static Future<bool> get isUserLoggedIn async {
    final user = await ParseUser.currentUser();
    return user != null;
  }

  // Método para obtener el usuario actual
  static Future<ParseUser?> get currentUser async {
    return await ParseUser.currentUser();
  }

  // Método para hacer logout
  static Future<void> logout() async {
    final user = await ParseUser.currentUser();
    if (user != null) {
      await user.logout();
    }
  }
}