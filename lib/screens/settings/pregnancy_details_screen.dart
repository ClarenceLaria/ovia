import 'package:flutter/material.dart';

class PregnancyDetailsPage extends StatefulWidget {
  const PregnancyDetailsPage({super.key});

  @override
  State<PregnancyDetailsPage> createState() => _PregnancyDetailsPageState();
}

class _PregnancyDetailsPageState extends State<PregnancyDetailsPage> {
  DateTime? _dueDate;
  String _selectedChildrenCount = '1';
  final TextEditingController _weightController = TextEditingController();
  bool _trackSymptoms = true;
  bool _trackBabyMovement = true;
  bool _trackBloodGlucose = true;
  bool _walkingSteadiness = true;
  bool _highHeartRate = true;
  bool _cardioFitness = false;
  bool _hydrationReminder = false;
  bool _kegelReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pregnancy Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Pregnancy Setup'),
            _datePickerField('Due Date', _dueDate, (date) => setState(() => _dueDate = date)),
            _dropdownField('Number of Children', _selectedChildrenCount, ['1', '2 (Twins)', '3+'],
                (value) => setState(() => _selectedChildrenCount = value!)),
            _textField('Pre-pregnancy Weight (kg)', _weightController),

            const SizedBox(height: 24),
            _sectionTitle('Tracking Features'),
            _toggleTile('Track Symptoms', _trackSymptoms, (val) => setState(() => _trackSymptoms = val)),
            _toggleTile('Track Baby Movement', _trackBabyMovement, (val) => setState(() => _trackBabyMovement = val)),
            _toggleTile('Track Blood Glucose', _trackBloodGlucose, (val) => setState(() => _trackBloodGlucose = val)),

            const SizedBox(height: 24),
            _sectionTitle('Notifications Settings'),
            _toggleTile('Walking Steadiness (Recommended ON in 3rd trimester)', _walkingSteadiness,
                (val) => setState(() => _walkingSteadiness = val)),
            _toggleTile('High Heart Rate (Alert if <120 bpm)', _highHeartRate,
                (val) => setState(() => _highHeartRate = val)),
            _toggleTile('Cardio Fitness Notifications (Recommended OFF)', _cardioFitness,
                (val) => setState(() => _cardioFitness = val)),

            const SizedBox(height: 24),
            _sectionTitle('Reminders and Health Tips'),
            _toggleTile('Hydration Reminders', _hydrationReminder, (val) => setState(() => _hydrationReminder = val)),
            _toggleTile('Kegel Exercise Reminders', _kegelReminder, (val) => setState(() => _kegelReminder = val)),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: (){}, 
                child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );

  Widget _dropdownField(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        value: value,
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _datePickerField(String label, DateTime? selectedDate, ValueChanged<DateTime> onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? now,
            firstDate: now.subtract(const Duration(days: 365)),
            lastDate: now.add(const Duration(days: 365 * 2)),
          );
          if (picked != null) onDateSelected(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          child: Text(selectedDate != null ? selectedDate.toLocal().toString().split(' ')[0] : 'Select Date'),
        ),
      ),
    );
  }

  Widget _toggleTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColorLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
