import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resuelvo_flutter/features/Home/detail_teacher_page.dart';
import 'package:resuelvo_flutter/features/Home/widgets/detail_teacher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todos';

  // sample data; in a real app this would come from a repository or API
  // in a real app this would come from a repository or API
  final List<Map<String, String>> _teachers = [
    {
      'name': 'Carlos Canto',
      'subject': 'Matemáticas',
      'image': '',
      'email': 'carlos.canto@ejemplo.com',
      'rating': '4.8',
      'hours': '120',
      'students': '300',
      'description': 'Profesor de Matemáticas con más de 10 años de experiencia. Especializado en álgebra y cálculo. Metodología dinámica y participativa que favorece el aprendizaje significativo.'
    },
    {
      'name': 'Ana López',
      'subject': 'Ciencias',
      'image': '',
      'email': 'ana.lopez@ejemplo.com',
      'rating': '4.5',
      'hours': '95',
      'students': '220',
      'description': 'Experta en Ciencias Naturales y Biología. Apasionada por incentivar el pensamiento científico en los estudiantes. Realiza experimentos interactivos y actividades prácticas.'
    },
    {
      'name': 'Jorge Ramírez',
      'subject': 'Lenguaje',
      'image': '',
      'email': 'jorge.ramirez@ejemplo.com',
      'rating': '4.2',
      'hours': '80',
      'students': '150',
      'description': 'Profesor de Lengua y Literatura con enfoque en comprensión lectora y expresión escrita. Promueve la lectura crítica y el análisis de textos.'
    },
    {
      'name': 'María Pérez',
      'subject': 'Historia',
      'image': '',
      'email': 'maria.perez@ejemplo.com',
      'rating': '4.9',
      'hours': '140',
      'students': '340',
      'description': 'Historiadora apasionada con especialidad en Historia Moderna y Contemporánea. Conecta el pasado con el presente de forma amena y educativa.'
    },
  ];

  List<String> get _categories => [
        'Todos',
        ..._teachers.map((t) => t['subject']!).toSet().toList()
      ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
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

  List<Map<String, String>> get _filteredTeachers {
    final query = _searchController.text.toLowerCase();
    return _teachers.where((t) {
      final matchesName = t['name']!.toLowerCase().contains(query);
      final matchesSubject = t['subject']!.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == 'Todos' || t['subject'] == _selectedCategory;
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
              child: _filteredTeachers.isEmpty
                  ? const Center(child: Text('No hay resultados'))
                  : ListView.builder(
                      itemCount: _filteredTeachers.length,
                      itemBuilder: (context, index) {
                        final t = _filteredTeachers[index];
                        return DetailTeacherWidget(
                          name: t['name']!,
                          subject: t['subject']!,
                          imageUrl: t['image']!.isEmpty ? null : t['image'],
                          email: t['email'],
                          rating: t['rating'] != null
                              ? double.tryParse(t['rating']!)
                              : null,
                          hours: t['hours'] != null
                              ? int.tryParse(t['hours']!)
                              : null,
                          students: t['students'] != null
                              ? int.tryParse(t['students']!)
                              : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTeacherPage(
                                  name: t['name']!,
                                  subject: t['subject']!,
                                  imageUrl: t['image']!.isEmpty ? null : t['image'],
                                  email: t['email'],
                                  description: t['description'],
                                  rating: t['rating'] != null
                                      ? double.tryParse(t['rating']!)
                                      : null,
                                  hours: t['hours'] != null
                                      ? int.tryParse(t['hours']!)
                                      : null,
                                  students: t['students'] != null
                                      ? int.tryParse(t['students']!)
                                      : null,
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
