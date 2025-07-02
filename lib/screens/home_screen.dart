import 'package:flutter/material.dart';
import '../components/category_card.dart';
import '../components/control_button.dart';
import 'add_machine_screen.dart';
import 'category_cars_screen.dart'; // Make sure to import this

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Add this method to handle category navigation
  void _openCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryCarsScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Machine Status',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  CategoryCard(
                    name: 'Luxury/Sedan',
                    icon: Icons.directions_car,
                    carCount: 5,
                    onPressed: () => _openCategory(context, 'Luxury/Sedan'),
                  ),
                  CategoryCard(
                    name: 'Sports Cars',
                    icon: Icons.sports_score,
                    carCount: 3,
                    onPressed: () => _openCategory(context, 'Sports Cars'),
                  ),
                  CategoryCard(
                    name: 'SUVs',
                    icon: Icons.local_shipping,
                    carCount: 4,
                    onPressed: () => _openCategory(context, 'SUVs'),
                  ),
                  CategoryCard(
                    name: 'Electric (EVs)',
                    icon: Icons.electric_car,
                    carCount: 2,
                    onPressed: () => _openCategory(context, 'Electric (EVs)'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Quick Controls',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ControlButton(
                    icon: Icons.play_arrow,
                    label: 'Start',
                    onPressed: () {},
                  ),
                  ControlButton(
                    icon: Icons.stop,
                    label: 'Stop',
                    onPressed: () {},
                  ),
                  ControlButton(
                    icon: Icons.refresh,
                    label: 'Reset',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 80), // Space for floating button
            ],
          ),
        ),
        
        // Add Machine Button
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMachineScreen(),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(151, 2, 77, 207),
            foregroundColor: Colors.white,
            elevation: 4,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add machine',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}