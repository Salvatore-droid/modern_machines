import 'package:flutter/material.dart';
import 'package:modern_machines/screens/machine_control_screen.dart';

class CarControlCard extends StatelessWidget {
  final String name;
  final String model;
  final String status;
  final int battery;
  final String imagePath;

  const CarControlCard({
    super.key,
    required this.name,
    required this.model,
    required this.status,
    required this.battery,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[850]!,
            Colors.grey[900]!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.directions_car, size: 50),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.directions_car, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getStatusColor(status),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                Text(
                  model,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 24),
                _buildBatteryIndicator(),
                const SizedBox(height: 24),
                _buildControlPanel(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatteryIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.battery_full, color: _getBatteryColor(battery), size: 20),
            const SizedBox(width: 8),
            Text(
              'POWER',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  width: constraints.maxWidth * (battery / 100),
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getBatteryColor(battery),
                        _getBatteryColor(battery).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: _getBatteryColor(battery).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$battery%',
            style: TextStyle(
              color: _getBatteryColor(battery),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildControlButton(context, Icons.power_settings_new, 'START', Colors.green),
          _buildControlButton(context, Icons.close, 'STOP', Colors.red),
          _buildControlButton(context, Icons.location_on, 'LOCATE', Colors.blue),
          _buildControlButton(context, Icons.tune, 'CONTROL', Colors.amber),
        ],
      ),
    );
  }

  Widget _buildControlButton(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
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
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: () {
              if (label == 'CONTROL') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MachineControlScreen(
                      machineName: name,
                      machineStatus: status,
                      batteryLevel: battery,
                    ),
                  ),
                );
              }
            },
          ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.greenAccent;
      case 'charging':
        return Colors.blueAccent;
      case 'idle':
        return Colors.amber;
      case 'maintenance':
        return Colors.orange;
      default:
        return Colors.white;
    }
  }

  Color _getBatteryColor(int level) {
    if (level > 70) return Colors.greenAccent;
    if (level > 30) return Colors.amber;
    return Colors.redAccent;
  }
}