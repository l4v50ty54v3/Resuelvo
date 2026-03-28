import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:resuelvo_flutter/core/resuelvo_colors.dart';
import 'package:resuelvo_flutter/features/Home/home_page.dart';
import 'package:resuelvo_flutter/features/Home/home_teacher_page.dart';
import 'package:resuelvo_flutter/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _remember = false;
  Role _role = Role.student;
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Mostrar loading
      setState(() => _isLoading = true);

      // Intentar login con Parse Server
      final user = await AuthService.login(_userController.text, _passwordController.text);

      if (user != null) {
        // Determinar el rol del usuario y navegar
        final userRole = user.get<String>('role') ?? 'student';

        if (!mounted) return;

        if (userRole == 'teacher') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeTeacherPage())
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage())
          );
        }
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
final Color primary = ResuelvoColors.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        centerTitle: true,
        backgroundColor: primary,
        titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        toolbarTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              // Encabezado simplificado
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.school, size: 44, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text('Resuelvo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 18),

                  // Selector de rol simple
                  ToggleButtons(
                    isSelected: [_role == Role.student, _role == Role.professor],
                    onPressed: (index) => setState(() => _role = index == 0 ? Role.student : Role.professor),
                    borderRadius: BorderRadius.circular(8),
                    children: const [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Estudiante')),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Profesor')),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Formulario compacto
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _userController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Usuario (DNI)',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa tu usuario' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Ingresa la contraseña' : null,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(value: _remember, onChanged: (v) => setState(() => _remember = v ?? false)),
                        const Text('Recordarme'),
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text('Olvidé contraseña')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text('Entrar', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Nota sobre registro: el botón de registro está en otra vista
                    Center(child: Text('Registrarse disponible en la vista de registro', style: TextStyle(color: Colors.grey[600], fontSize: 12))),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Center(child: Text('App • Resuelvo', style: TextStyle(color: Colors.grey[600]))),
            ],
          ),
        ),
      ),
    );
  }
}

enum Role { student, professor }