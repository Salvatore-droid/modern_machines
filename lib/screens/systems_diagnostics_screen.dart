import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SystemsDiagnosticsScreen extends StatefulWidget {
  final String vehicleName;

  const SystemsDiagnosticsScreen({super.key, required this.vehicleName});

  @override
  State<SystemsDiagnosticsScreen> createState() => _SystemsDiagnosticsScreenState();
}

class _SystemsDiagnosticsScreenState extends State<SystemsDiagnosticsScreen> {
  final Map<String, double> _systemHealth = {
    'Engine': 87.5,
    'Battery': 64.2,
    'Transmission': 92.0,
    'Brakes': 78.3,
    'Suspension': 81.7,
    'Electronics': 95.4,
    'Cooling': 72.9,
  };

  final Map<String, String> _errorCodes = {
    'ECU-1024': 'Engine control module',
    'BATT-2051': 'Cell voltage imbalance',
    'TRN-3072': 'Gear shift solenoid',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.vehicleName} Diagnostics'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showDiagnosticHistory,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showAdvancedOptions,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121212),
              Color(0xFF1A1A1A),
            ],
          ),
        ),
        child: Column(
          children: [
            // Health Overview Gauge
            _buildHealthOverviewGauge(),
            const SizedBox(height: 24),

            // System Health Grid
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _systemHealth.entries.map((entry) {
                  return _buildSystemHealthCard(entry.key, entry.value);
                }).toList(),
              ),
            ),

            // Error Codes Section
            _buildErrorCodesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthOverviewGauge() {
    final overallHealth = _systemHealth.values.reduce((a, b) => a + b) / 
                         _systemHealth.length;

    return SizedBox(
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.1,
              color: Colors.white24,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: overallHealth,
                width: 24,
                color: _getHealthColor(overallHealth),
                enableAnimation: true,
                animationDuration: 1500,
                gradient: SweepGradient(
                  colors: [
                    _getHealthColor(overallHealth).withOpacity(0.8),
                    _getHealthColor(overallHealth).withOpacity(0.3),
                  ],
                ),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.5,
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${overallHealth.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _getHealthColor(overallHealth),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Overall Health',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemHealthCard(String system, double health) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFF252525),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getSystemIcon(system),
                  color: _getHealthColor(health),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  system,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${health.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: _getHealthColor(health),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: health / 100,
              backgroundColor: Colors.white10,
              color: _getHealthColor(health),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Text(
              _getHealthStatus(health),
              style: TextStyle(
                color: _getHealthColor(health),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCodesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACTIVE ERROR CODES',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          ..._errorCodes.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    color: Colors.white54,
                    onPressed: () => _showErrorDetails(entry.key),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  IconData _getSystemIcon(String system) {
    switch (system) {
      case 'Engine':
        return Icons.engineering;
      case 'Battery':
        return Icons.battery_charging_full;
      case 'Transmission':
        return Icons.settings_input_component;
      case 'Brakes':
        return Icons.car_crash;
      case 'Suspension':
        return Icons.air;
      case 'Electronics':
        return Icons.electrical_services;
      case 'Cooling':
        return Icons.ac_unit;
      default:
        return Icons.build;
    }
  }

  Color _getHealthColor(double value) {
    if (value > 85) return Colors.greenAccent;
    if (value > 60) return Colors.blueAccent;
    if (value > 40) return Colors.amber;
    return Colors.redAccent;
  }

  String _getHealthStatus(double value) {
    if (value > 85) return 'Optimal Performance';
    if (value > 60) return 'Normal Operation';
    if (value > 40) return 'Requires Attention';
    return 'Critical Service Needed';
  }

  void _showErrorDetails(String errorCode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252525),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error Code: $errorCode',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorCodes[errorCode] ?? 'Unknown error',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recommended Actions:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildActionItem('Run full system diagnostic'),
            _buildActionItem('Check wiring connections'),
            _buildActionItem('Consult service manual'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('DISMISS ALERT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.redAccent),
          const SizedBox(width: 12),
          Text(
            action,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  void _showDiagnosticHistory() {
    // Implement history view
  }

  void _showAdvancedOptions() {
    // Implement advanced options
  }
}