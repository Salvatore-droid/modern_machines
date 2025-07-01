import 'package:flutter/material.dart';

class AddMachineScreen extends StatefulWidget {
  const AddMachineScreen({super.key});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _serialController = TextEditingController();
  String _machineType = 'Tractor';
  String _connectionType = 'WiFi';
  int _batteryLevel = 100;
  bool _enableAutoUpdates = true;

  @override
  void dispose() {
    _nameController.dispose();
    _serialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Machine'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: const Text('SAVE', style: TextStyle(color: Colors.blueAccent)),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Machine Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Register a new machine to your fleet',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),

                // Machine Name
                _buildSectionHeader('Basic Information'),
                _buildTextField(
                  controller: _nameController,
                  label: 'Machine Name',
                  hint: 'e.g. Field Tractor #5',
                  icon: Icons.agriculture,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Machine Type Dropdown
                _buildDropdown(
                  value: _machineType,
                  items: const ['Tractor', 'Harvester', 'Sprayer', 'Cultivator'],
                  label: 'Machine Type',
                  icon: Icons.category,
                  onChanged: (value) => setState(() => _machineType = value!),
                ),
                const SizedBox(height: 16),

                // Serial Number
                _buildTextField(
                  controller: _serialController,
                  label: 'Serial Number',
                  hint: 'Optional',
                  icon: Icons.confirmation_number,
                ),
                const SizedBox(height: 32),

                // Connection Settings
                _buildSectionHeader('Connection Settings'),
                _buildDropdown(
                  value: _connectionType,
                  items: const ['WiFi', 'Bluetooth', 'Cellular', 'Manual'],
                  label: 'Connection Type',
                  icon: Icons.settings_input_antenna,
                  onChanged: (value) => setState(() => _connectionType = value!),
                ),
                const SizedBox(height: 24),

                // Battery Level
                _buildSectionHeader('Battery Status'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.battery_full, color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '$_batteryLevel%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _batteryLevel.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: _getBatteryColor(),
                        inactiveColor: Colors.blueGrey[800],
                        thumbColor: Colors.white,
                        onChanged: (value) => setState(() => _batteryLevel = value.round()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Advanced Settings
                _buildSectionHeader('Advanced'),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Enable Automatic Updates',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Machine will receive firmware updates automatically',
                    style: TextStyle(color: Colors.white54),
                  ),
                  value: _enableAutoUpdates,
                  activeColor: Colors.blueAccent,
                  onChanged: (value) => setState(() => _enableAutoUpdates = value),
                ),
                const SizedBox(height: 48),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'REGISTER MACHINE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBatteryColor() {
    if (_batteryLevel > 70) return Colors.greenAccent;
    if (_batteryLevel > 30) return Colors.amber;
    return Colors.redAccent;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF252525),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // In your final implementation, you'll process the form here
      Navigator.pop(context);
    }
  }
}