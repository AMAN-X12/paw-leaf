
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _roomController = TextEditingController();
  final _notesController = TextEditingController();

  String selectedType = 'Pet';
  DateTime? selectedDate;
  bool suggestReminders = true;

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _roomController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_nameController.text} saved successfully!')),
    );

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add pet or plant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Pet', label: Text('Pet')),
                ButtonSegment(value: 'Plant', label: Text('Plant')),
              ],
              selected: {selectedType},
              onSelectionChanged: (value) {
                setState(() => selectedType = value.first);
              },
            ),

            const SizedBox(height: 24),

            Container(
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined, size: 42),
                  SizedBox(height: 8),
                  Text('Take photo / choose from gallery'),
                  Text(
                    'Photo upload will be added later',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildLabel('Name'),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'e.g. Monty / Monstera',
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Please enter a name'
                      : null,
            ),

            const SizedBox(height: 16),

            _buildLabel(selectedType == 'Pet' ? 'Species or breed' : 'Species'),
            TextFormField(
              controller: _speciesController,
              decoration: const InputDecoration(
                hintText: 'Search species...',
                suffixIcon: Icon(Icons.search),
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Please enter a species'
                      : null,
            ),

            const SizedBox(height: 16),

            _buildLabel(
              selectedType == 'Pet' ? 'Birthday' : 'Acquired date',
            ),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? 'dd / mm / yyyy'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Room / home'),
            TextFormField(
              controller: _roomController,
              decoration: const InputDecoration(
                hintText: 'e.g. Living room',
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Notes (care notes only)'),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add some notes...',
              ),
            ),

            const SizedBox(height: 12),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: suggestReminders,
              title: const Text('Suggest reminders from species'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() => suggestReminders = value ?? false);
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
