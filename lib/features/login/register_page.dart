import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    _cityController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _pickImage() {
    // Placeholder: integrar ImagePicker o selector de archivos aquí.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seleccionar foto: integración pendiente')),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí iría la lógica para enviar datos al backend o servicio.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrando usuario...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                      child: const Icon(Icons.camera_alt, size: 36),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(child: Text('Añadir foto de perfil', style: TextStyle(fontSize: 12))),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'Nombres', prefixIcon: Icon(Icons.person)),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa tus nombres' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Apellidos', prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa tus apellidos' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Teléfono', prefixIcon: Icon(Icons.phone)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _dniController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'DNI', prefixIcon: Icon(Icons.badge)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'Ciudad', prefixIcon: Icon(Icons.location_city)),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _aboutController,
                  decoration: const InputDecoration(labelText: 'Un poco sobre ti', alignLabelWithHint: true),
                  maxLines: 4,
                ),

                const SizedBox(height: 20),
                ElevatedButton(onPressed: _submit, child: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Crear cuenta'))),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
