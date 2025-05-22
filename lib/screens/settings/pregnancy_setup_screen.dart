import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/api_connectors/login.dart';

class PregnancySetupScreen extends StatefulWidget {
  const PregnancySetupScreen({super.key});

  @override
  State<PregnancySetupScreen> createState() => _PregnancySetupScreenState();
}

class _PregnancySetupScreenState extends State<PregnancySetupScreen> {
  bool isPregnant = false;
  String selectedOption = '';
  DateTime? selectedDueDate;
  DateTime? selectedlmpDate;
  int? weeksPregnant;
  final String userId = Auth().currentUser?.uid ?? '';

  final TextEditingController weeksController = TextEditingController();

  void _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null && mounted) {
      if(selectedOption == 'dueDate'){
        setState(() {
          selectedDueDate = picked;
        });
      } else {
        setState(() {
          selectedlmpDate = picked;
        });
      }
    }
  }

  void _submit() async{
    if (!isPregnant) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm if you are pregnant.')),
      );
      return;
    }

    if (selectedOption == 'weeks' && weeksController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the number of weeks.')),
      );
      return;
    }

    if (selectedOption == 'dueDate' &&
        selectedDueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date.')),
      );
      return;
    }

    if (selectedOption == 'lmp' &&
        selectedlmpDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date.')),
      );
      return;
    }

    try{
      final response = await APIs().postPregnancyInfo(
        userId: userId,
        weeksPregnant: int.parse(weeksController.text),
        dueDate: selectedDueDate?.toIso8601String() ?? '',
        lmp: selectedlmpDate?.toIso8601String() ?? '',
      );

      if(response == 'Pregnancy info submitted successfully'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pregnancy information submitted successfully.'), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating),
        );

        Navigator.pop(context);
      }
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while submitting your data.'), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating),
      );
      return;
    }   
  }

  @override
  void dispose() {
    weeksController.dispose();
    super.dispose();
  }

  Widget _buildInputSection() {
    switch (selectedOption) {
      case 'weeks':
        return TextField(
          controller: weeksController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'How many weeks pregnant are you?',
            border: OutlineInputBorder(),
          ),
        );
      case 'dueDate':
        return ListTile(
          title: const Text("Select your due date"),
          subtitle: Text(
            selectedDueDate != null
                ? DateFormat.yMMMMd().format(selectedDueDate!)
                : 'No date selected',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => _pickDate(context),
        );
      case 'lmp':
        return ListTile(
          title: const Text("Select your last menstrual period (LMP)"),
          subtitle: Text(
            selectedlmpDate != null
                ? DateFormat.yMMMMd().format(selectedlmpDate!)
                : 'No date selected',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => _pickDate(context),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregnancy Setup"),
        centerTitle: true,
      ),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Are you currently pregnant?"),
              value: isPregnant,
              activeColor: Colors.pink,
              onChanged: (value) {
                setState(() {
                  isPregnant = value;
                  selectedOption = '';
                  selectedDueDate = null;
                  selectedlmpDate = null;
                  weeksController.clear();
                });
              },
            ),
            if (isPregnant) ...[
              const SizedBox(height: 16),
              const Text("How do you want to provide your pregnancy info?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: const Text("Number of weeks pregnant"),
                leading: Radio<String>(
                  value: 'weeks',
                  groupValue: selectedOption,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    setState(() => selectedOption = value!);
                  },
                ),
              ),
              ListTile(
                title: const Text("Due date"),
                leading: Radio<String>(
                  value: 'dueDate',
                  groupValue: selectedOption,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    setState(() => selectedOption = value!);
                  },
                ),
              ),
              ListTile(
                title: const Text("Last menstrual period (LMP)"),
                leading: Radio<String>(
                  value: 'lmp',
                  groupValue: selectedOption,
                  activeColor: Colors.pink,
                  onChanged: (value) {
                    setState(() => selectedOption = value!);
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildInputSection(),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
