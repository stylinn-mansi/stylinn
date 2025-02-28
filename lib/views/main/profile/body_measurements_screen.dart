import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';

class BodyMeasurementsScreen extends ConsumerStatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  ConsumerState<BodyMeasurementsScreen> createState() => _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState extends ConsumerState<BodyMeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for each measurement field
  final _heightController = TextEditingController(text: '175');
  final _weightController = TextEditingController(text: '70');
  final _chestController = TextEditingController(text: '95');
  final _waistController = TextEditingController(text: '80');
  final _hipsController = TextEditingController(text: '95');
  final _shoulderController = TextEditingController(text: '45');
  final _inseamController = TextEditingController(text: '80');
  
  // Units
  String _heightUnit = 'cm';
  String _weightUnit = 'kg';
  String _measurementUnit = 'cm';
  
  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    _shoulderController.dispose();
    _inseamController.dispose();
    super.dispose();
  }
  
  void _saveMeasurements() {
    if (_formKey.currentState!.validate()) {
      // Here we would normally save the measurements
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Measurements saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Body Measurements',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: _saveMeasurements,
            child: Text(
              'Save',
              style: TextStyle(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Body illustration
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.accessibility_new,
                      size: 120,
                      color: AppTheme.primaryGold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Height and Weight
                Row(
                  children: [
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _heightController,
                        label: 'Height',
                        unit: _heightUnit,
                        onUnitTap: () {
                          setState(() {
                            _heightUnit = _heightUnit == 'cm' ? 'in' : 'cm';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _weightController,
                        label: 'Weight',
                        unit: _weightUnit,
                        onUnitTap: () {
                          setState(() {
                            _weightUnit = _weightUnit == 'kg' ? 'lb' : 'kg';
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Section title
                const Text(
                  'Upper Body',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Chest and Shoulder
                Row(
                  children: [
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _chestController,
                        label: 'Chest',
                        unit: _measurementUnit,
                        onUnitTap: () {
                          setState(() {
                            _measurementUnit = _measurementUnit == 'cm' ? 'in' : 'cm';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _shoulderController,
                        label: 'Shoulder',
                        unit: _measurementUnit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Section title
                const Text(
                  'Lower Body',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Waist and Hips
                Row(
                  children: [
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _waistController,
                        label: 'Waist',
                        unit: _measurementUnit,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _hipsController,
                        label: 'Hips',
                        unit: _measurementUnit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Inseam
                Row(
                  children: [
                    Expanded(
                      child: _buildMeasurementField(
                        controller: _inseamController,
                        label: 'Inseam',
                        unit: _measurementUnit,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Tip
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppTheme.primaryGold,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Accurate measurements help us recommend better fitting clothes for you.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementField({
    required TextEditingController controller,
    required String label,
    required String unit,
    VoidCallback? onUnitTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixText: unit,
            suffixStyle: TextStyle(
              color: onUnitTap != null ? AppTheme.primaryGold : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (double.tryParse(value) == null) {
              return 'Invalid number';
            }
            return null;
          },
          onTap: () {
            if (onUnitTap != null) {
              // This would allow changing the unit when tapping on the field
              // but we'll keep it simple for now
            }
          },
        ),
      ],
    );
  }
} 