import 'package:flutter/material.dart';
import '../screens/machine_control_screen.dart';


class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final int carCount;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.carCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: Colors.blueAccent),
              const SizedBox(height: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$carCount vehicles',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}