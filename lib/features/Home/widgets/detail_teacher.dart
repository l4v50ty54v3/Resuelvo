import 'package:flutter/material.dart';

class DetailTeacherWidget extends StatelessWidget {
  final String name;
  final String subject;
  final String? imageUrl;
  final String? email;
  final double? rating;
  final int? hours;
  final int? students;
  final VoidCallback? onTap;

  const DetailTeacherWidget({
    super.key,
    required this.name,
    required this.subject,
    this.imageUrl,
    this.email,
    this.rating,
    this.hours,
    this.students,
    this.onTap,
  });

  String get _initials {
    final parts = name.split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1);
    return parts.map((p) => p.substring(0, 1)).take(2).join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: imageUrl == null
                      ? Center(
                          child: Text(
                            _initials,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subject,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      if (email != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              email!,
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                      if (rating != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating!.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                      if (hours != null || students != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            if (hours != null) ...[
                              const Icon(Icons.access_time, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${hours!}h',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                            if (hours != null && students != null)
                              const SizedBox(width: 12),
                            if (students != null) ...[
                              const Icon(Icons.group, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${students!}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // if (onTap != null) ...[
                //   const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                //   const SizedBox(width: 4),
                //   TextButton(
                //     onPressed: onTap,
                //     child: const Text('Ver más'),
                //     style: TextButton.styleFrom(
                //       padding: EdgeInsets.zero,
                //       minimumSize: const Size(50, 30),
                //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //     ),
                //   ),
                //],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
