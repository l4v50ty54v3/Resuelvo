import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:resuelvo_flutter/core/resuelvo_colors.dart';
import 'package:resuelvo_flutter/models/parse_teacher.dart';
import 'package:resuelvo_flutter/models/parse_class.dart';
import 'package:resuelvo_flutter/models/parse_request.dart';
import 'package:resuelvo_flutter/models/parse_student.dart';
import 'package:resuelvo_flutter/services/auth_service.dart';
import 'package:resuelvo_flutter/services/class_service.dart';
import 'package:resuelvo_flutter/services/request_service.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  ParseTeacher? _teacher;
  List<ParseClass> _classes = [];
  List<ParseRequest> _pendingRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final currentUser = await AuthService.getCurrentUser();
      if (currentUser != null) {
        // Cargar perfil del profesor
        _teacher = await AuthService.getTeacherProfile(currentUser.objectId!);

        if (_teacher != null) {
          // Cargar clases del profesor
          _classes = await ClassService.getClassesByTeacher(_teacher!.objectId!);

          // Cargar solicitudes pendientes
          _pendingRequests = await RequestService.getPendingRequests(_teacher!.objectId!);
        }
      }
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = ResuelvoColors.primary;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Panel del Profesor', style: TextStyle(color: Colors.white)),
          backgroundColor: primary,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel del Profesor', style: TextStyle(color: Colors.white)),
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await AuthService.logout();
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Teacher Profile Section
              if (_teacher != null) _buildProfileSection(primary, _teacher!),

              const SizedBox(height: 24),

              // Classes Section
              _buildSectionTitle('Mis Clases'),
              _buildClassesList(_classes),

              const SizedBox(height: 24),

              // Pending Requests Section
              _buildSectionTitle('Solicitudes Pendientes (${_pendingRequests.length})'),
              _buildPendingRequestsList(_pendingRequests),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(Color primary, ParseTeacher teacher) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: teacher.user?.profileImageUrl != null
                  ? NetworkImage(teacher.user!.profileImageUrl!)
                  : null,
              backgroundColor: primary.withOpacity(0.1),
              child: teacher.user?.profileImageUrl == null
                  ? Text(
                      teacher.user?.name[0].toUpperCase() ?? 'P',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher.user?.name ?? 'Profesor',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacher.subject,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacher.user?.email ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  if (teacher.bio != null && teacher.bio!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      teacher.bio!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildClassesList(List<ParseClass> classes) {
    if (classes.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('No tienes clases asignadas'),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classObj = classes[index];
        return Card(
          margin: const EdgeInsets.only(top: 8),
          child: ListTile(
            title: Text(classObj.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(classObj.schedule),
                Text('${classObj.currentStudents}/${classObj.maxStudents} alumnos'),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to class details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ver detalles de ${classObj.name}')),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPendingRequestsList(List<ParseRequest> requests) {
    if (requests.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('No tienes solicitudes pendientes'),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.only(top: 8),
          child: ListTile(
            leading: const Icon(Icons.pending, color: Colors.orange),
            title: Text(request.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(
                  'Tipo: ${request.type.name}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to request details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ver solicitud: ${request.title}')),
              );
            },
          ),
        );
      },
    );
  }
}