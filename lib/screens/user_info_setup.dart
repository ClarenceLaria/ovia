import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoSetupPage extends StatefulWidget {
  const UserInfoSetupPage({super.key});

  @override
  State<UserInfoSetupPage> createState() => _UserInfoSetupPageState();
}

class _UserInfoSetupPageState extends State<UserInfoSetupPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _lastPeriodDate;
  final _cycleLengthController = TextEditingController();
  final _periodDurationController = TextEditingController();
  final _birthYearController = TextEditingController();
  String? _cycleType;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 28)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _lastPeriodDate) {
      setState(() {
        _lastPeriodDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _cycleLengthController.dispose();
    _periodDurationController.dispose();
    _birthYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Setup Your Cycle Info'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Let's get to know your cycle better",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Last Period Date Picker
              GestureDetector(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'First Day of Last Period',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  child: Text(
                    _lastPeriodDate == null
                        ? 'Tap to select date'
                        : DateFormat('yMMMd').format(_lastPeriodDate!),
                    style: TextStyle(
                      color: _lastPeriodDate == null
                          ? Colors.grey[600]
                          : Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Average Cycle Length
              TextFormField(
                controller: _cycleLengthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Average Cycle Length (days)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Average Period Duration
              TextFormField(
                controller: _periodDurationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Average Period Duration (days)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Birth Year (Optional)
              TextFormField(
                controller: _birthYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Birth Year (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Cycle Type
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Cycle Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: _cycleType,
                items: const [
                  DropdownMenuItem(
                    value: 'Regular',
                    child: Text('Regular'),
                  ),
                  DropdownMenuItem(
                    value: 'Irregular',
                    child: Text('Irregular'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _cycleType = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _lastPeriodDate != null &&
                      _cycleType != null) {
                    // 🔄 Collect data
                    final lastPeriodDate = _lastPeriodDate!.toIso8601String();
                    final cycleLength = int.parse(_cycleLengthController.text);
                    final periodDuration =
                        int.parse(_periodDurationController.text);
                    final birthYear = _birthYearController.text.isNotEmpty
                        ? int.parse(_birthYearController.text)
                        : null;
                    final cycleType = _cycleType;

                    try {
                      // ✅ Save to your Firebase backend (replace this with your actual API call)
                      // await FirebaseService.saveUserInfo(setupData);
                      final result = await APIs().postUserSetupInfo(
                          lastPeriodDate: lastPeriodDate,
                          cycleLength: cycleLength,
                          periodDuration: periodDuration,
                          birthYear: birthYear!,
                          cycleType: cycleType!);
                      if (result == 'User info posted successfully') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Info stored successfully'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        // ✅ Save locally that setup is complete
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isSetupComplete', true);

                        // ✅ Navigate to home
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EntryPoint()),
                          );
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to save info: $e'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all required fields'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
