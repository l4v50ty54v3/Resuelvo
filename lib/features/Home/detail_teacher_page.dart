import 'package:flutter/material.dart';

class DetailTeacherPage extends StatelessWidget {
  final String name;
  final String subject;
  final String? imageUrl;
  final String? email;
  final String? description;
  final double? rating;
  final int? hours;
  final int? students;

  const DetailTeacherPage({
    super.key,
    required this.name,
    required this.subject,
    this.imageUrl,
    this.email,
    this.description,
    this.rating,
    this.hours,
    this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Profesor'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? const Center(
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 24),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (rating != null || hours != null || students != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (rating != null) ...[
                        const Icon(Icons.star, size: 18, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          rating!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (hours != null) ...[
                        const Icon(Icons.access_time, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${hours!}h',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (students != null) ...[
                        const Icon(Icons.group, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${students!}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: 20),
                if (email != null)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email, size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            email!,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      // Navegar al chat
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('Ir al Chat'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (description != null)
                  Column(
                    children: [
                      const Text(
                        'Acerca del Profesor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}