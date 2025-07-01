import 'package:flutter/material.dart';
import '../components/car_control_card.dart';

class CategoryCarsScreen extends StatelessWidget {
  final String category;

  const CategoryCarsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          category.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: const Center(
                child: Icon(
                  Icons.directions_car,
                  size: 300,
                  color: Colors.white24,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueAccent.withOpacity(0.1),
                      Colors.blueAccent.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.directions_car_filled,
                        color: Colors.blueAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CATEGORY OVERVIEW',
                          style: TextStyle(
                            color: Colors.blueAccent.withOpacity(0.8),
                            fontSize: 12,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '4 Vehicles Connected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white54,
                      size: 28,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 120),
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    CarControlCard(
                      name: 'Porsche',
                      model: '911 Turbo S',
                      status: 'Active',
                      battery: 92,
                      imagePath: 'assets/porsche_911.jpg',
                    ),
                    CarControlCard(
                      name: 'Tesla',
                      model: 'Model S Plaid',
                      status: 'Charging',
                      battery: 45,
                      imagePath: 'assets/tesla_model_s.jpg',
                    ),
                    CarControlCard(
                      name: 'Range Rover',
                      model: 'Autobiography',
                      status: 'Idle',
                      battery: 78,
                      imagePath: 'assets/range_rover.jpg',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[900]!.withOpacity(0.8),
                    Colors.grey[900]!.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMasterControl('Start All', Icons.play_arrow, Colors.green),
                  _buildMasterControl('Stop All', Icons.stop, Colors.red),
                  _buildMasterControl('Locate', Icons.location_on, Colors.blue),
                  _buildMasterControl('Settings', Icons.settings, Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterControl(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}