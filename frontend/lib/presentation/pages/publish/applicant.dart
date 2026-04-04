import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';

class PublishApplicantPage extends ConsumerStatefulWidget {
  const PublishApplicantPage({super.key});

  @override
  ConsumerState<PublishApplicantPage> createState() => _PublishApplicantPageState();
}

class _PublishApplicantPageState extends ConsumerState<PublishApplicantPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _name = '';
  DateTime? _dateOfBirth;
  EducationType _education = EducationType.bachelor;
  String _university = '';
  bool _graduated = false;
  SpecialtyType _specialty = SpecialtyType.frontend;
  LevelType _level = LevelType.junior;
  int _experience = 0;
  String _workHistory = '';
  List<String> _languages = [];
  List<String> _technologies = [];

  bool _isPublishing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Publish Resume'),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personal Information", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Full Name',
                onChanged: (val) => setState(() => _name = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              DatePickerField(
                label: 'Date of Birth',
                selectedDate: _dateOfBirth,
                onDateSelected: (date) => setState(() => _dateOfBirth = date),
              ),
              const SizedBox(height: 32),
              
              Text("Education", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              SingleChoiceField<EducationType>(
                label: 'Education Level',
                value: _education,
                items: EducationType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
                onChanged: (val) => setState(() => _education = val ?? EducationType.bachelor),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'University',
                onChanged: (val) => setState(() => _university = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter your university' : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Graduated"),
                value: _graduated,
                onChanged: (val) => setState(() => _graduated = val),
              ),
              const SizedBox(height: 32),

              Text("Professional Details", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              SingleChoiceField<SpecialtyType>(
                label: 'Specialty',
                value: _specialty,
                items: SpecialtyType.values.map((s) => DropdownMenuItem(value: s, child: Text(s.displayName))).toList(),
                onChanged: (val) => setState(() => _specialty = val ?? SpecialtyType.frontend),
              ),
              const SizedBox(height: 16),
              SingleChoiceField<LevelType>(
                label: 'Level',
                value: _level,
                items: LevelType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
                onChanged: (val) => setState(() => _level = val ?? LevelType.junior),
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Experience (years)',
                initialValue: _experience,
                onChanged: (val) => setState(() => _experience = val ?? 0),
                validator: (val) => val == null || val.isEmpty ? 'Please enter your experience' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Work History',
                maxLines: 5,
                onChanged: (val) => setState(() => _workHistory = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter your work history' : null,
              ),
              const SizedBox(height: 16),
              SearchableMultiChoiceField<String>(
                label: 'Technologies',
                values: DataService.technologies,
                selectedValues: _technologies,
                labelBuilder: (s) => s,
                onChanged: (val) => setState(() => _technologies = val),
              ),
              const SizedBox(height: 16),
              SearchableMultiChoiceField<String>(
                label: 'Languages',
                values: DataService.languages,
                selectedValues: _languages,
                labelBuilder: (s) => s,
                onChanged: (val) => setState(() => _languages = val),
              ),
              const SizedBox(height: 40),
              
              Center(
                child: ElevatedButton(
                  onPressed: _isPublishing ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: _isPublishing 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Publish Resume', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select your date of birth")));
       return;
    }

    setState(() => _isPublishing = true);
    
    try {
      final applicant = Applicant(
        id: 0, // Server should assign ID
        name: _name,
        dateOfBirth: _dateOfBirth!,
        education: _education,
        university: _university,
        graduated: _graduated,
        specialty: _specialty,
        level: _level,
        experience: _experience,
        workHistory: _workHistory,
        languages: _languages,
        technologies: _technologies,
      );
      
      await ApiService().createApplicant(applicant);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Resume published successfully!")));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isPublishing = false);
    }
  }
}
