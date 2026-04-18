import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resuelvo_flutter/features/Home/detail_teacher_page.dart';
import 'package:resuelvo_flutter/features/Home/widgets/detail_teacher.dart';
import 'package:resuelvo_flutter/models/models.dart';
import 'package:resuelvo_flutter/models/parse_teacher.dart';
import '../../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todos';


  List<ParseTeacher> _teachers = [];
  bool _isLoading = true;
  List<String> get _categories => [
    'Todos',
    ..._teachers.map((t) => t.subject).toSet().toList(),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadTeachers();
  }

  Future<void> _loadTeachers() async {
    final teachers = await ParseTeacher.getAllTeachers();
    setState(() {
      _teachers = teachers;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _logout() async {
    try {
      await AuthService.logout();
      if (!mounted) return;
      // Navegar a la pantalla de login (asumiendo que está en la ruta raíz)
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: ${e.toString()}')),
      );
    }
  }

 
  List<ParseTeacher> get _filteredTeachers {
    final query = _searchController.text.toLowerCase();
    return _teachers.where((t) {
      final matchesName = t.user?.name.toLowerCase().contains(query) ?? false;
      final matchesSubject = t.subject.toLowerCase().contains(query);
      final matchesCategory =
          _selectedCategory == 'Todos' || t.subject == _selectedCategory;
      return (matchesName || matchesSubject) && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const CircleAvatar(radius: 20),
        ),
        title: const Text('Inicio'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Resuelvo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tu plataforma de aprendizaje',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cerrar el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mi Perfil'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a la página de perfil
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil - Funcionalidad pendiente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Mis Clases'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a las clases del usuario
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mis Clases - Funcionalidad pendiente')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a configuración
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración - Funcionalidad pendiente')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Buscar profesor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CupertinoSearchTextField(controller: _searchController),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final selected = category == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 20, thickness: 1),
            Expanded(
              child:
                  _filteredTeachers.isEmpty
                      ? const Center(child: Text('No hay resultados'))
                      : ListView.builder(
                        itemCount: _filteredTeachers.length,
                        itemBuilder: (context, index) {
                          final t = _filteredTeachers[index];
                          return DetailTeacherWidget(
                            name: t.user?.name ?? '',
                            subject: t.subject,
                            imageUrl: t.user?.profileImageUrl,
                            // email: t['email'],
                            rating: t.rating,
                            hours: t.totalHours,
                            students: t.totalStudents,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailTeacherPage(
                                        name: t.user?.name ?? '',
                                        subject: t.subject,
                                        imageUrl: t.user?.profileImageUrl,
                                        // email: t['email'],
                                        description: t.bio,
                                        rating: t.rating,
                                        hours: t.totalHours,
                                        students: t.totalStudents,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
