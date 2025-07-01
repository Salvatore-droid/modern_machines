import 'package:flutter/material.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final List<MaintenanceItem> _items = [
    MaintenanceItem(
      'Engine Oil', 
      85, 
      'Next change in 15 days', 
      Colors.amber,
      Icons.local_car_wash
    ),
    MaintenanceItem(
      'Air Filter', 
      45, 
      'Inspection recommended', 
      Colors.orange,
      Icons.air
    ),
    MaintenanceItem(
      'Hydraulics', 
      92, 
      'Optimal condition', 
      Colors.green,
      Icons.opacity
    ),
    MaintenanceItem(
      'Battery', 
      78, 
      'Check connections', 
      Colors.blue,
      Icons.battery_charging_full
    ),
    MaintenanceItem(
      'Tires', 
      65, 
      'Rotation needed', 
      Colors.deepOrange,
      Icons.directions_car
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictive Maintenance'),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
            ],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Component Health Status',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) => _MaintenanceCard(item: _items[index]),
              ),
            ),
            _buildPredictiveInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictiveInsights() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF252525),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI Recommendations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70
          ),
        ),
        const SizedBox(height: 8),
        _buildRecommendationItem('Schedule oil change before next Thursday'),
        _buildRecommendationItem('Check hydraulic pressure sensors'),
        _buildRecommendationItem('Rotate tires in next 200km'),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,  // Fixed typo here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text('Schedule Maintenance'),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildRecommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.circle, size: 8, color: Colors.blueAccent),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class MaintenanceItem {
  final String name;
  final int health;
  final String status;
  final Color color;
  final IconData icon;

  MaintenanceItem(this.name, this.health, this.status, this.color, this.icon);
}

class _MaintenanceCard extends StatelessWidget {
  final MaintenanceItem item;

  const _MaintenanceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF252525),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(item.icon, color: item.color),
                const SizedBox(width: 12),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: item.health / 100,
              backgroundColor: item.color.withOpacity(0.2),
              color: item.color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${item.health}%',
                  style: TextStyle(
                    color: item.color,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Spacer(),
                Text(
                  item.status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}