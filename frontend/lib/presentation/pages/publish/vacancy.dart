import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';

class PublishVacancyPage extends ConsumerStatefulWidget {
  const PublishVacancyPage({super.key});

  @override
  ConsumerState<PublishVacancyPage> createState() => _PublishVacancyPageState();
}

class _PublishVacancyPageState extends ConsumerState<PublishVacancyPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _title = '';
  String _description = '';
  int _companyID = 0;
  String _companyName = '';
  SpecialtyType _specialty = SpecialtyType.frontend;
  LevelType _level = LevelType.junior;
  int _experience = 0;
  int _salary = 0;
  int _hours = 40;
  EmploymentType _employment = EmploymentType.fullTime;
  LocationType _location = LocationType.remote;
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
            const Text('Post a Vacancy'),
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
              Text("Basic Information", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Job Title',
                onChanged: (val) => setState(() => _title = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter job title' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Description',
                maxLines: 5,
                onChanged: (val) => setState(() => _description = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter description' : null,
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Company ID',
                onChanged: (val) => setState(() => _companyID = val ?? 0),
                validator: (val) => val == null || val.isEmpty ? 'Please enter company ID' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Company Name',
                onChanged: (val) => setState(() => _companyName = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter company name' : null,
              ),
              const SizedBox(height: 32),

              Text("Requirements", style: Theme.of(context).textTheme.headlineSmall),
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
                label: 'Expertise Level',
                value: _level,
                items: LevelType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
                onChanged: (val) => setState(() => _level = val ?? LevelType.junior),
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Experience Required (years)',
                initialValue: _experience,
                onChanged: (val) => setState(() => _experience = val ?? 0),
                validator: (val) => val == null || val.isEmpty ? 'Please enter experience' : null,
              ),
              const SizedBox(height: 16),
              SearchableMultiChoiceField<String>(
                label: 'Required Technologies',
                values: DataService.technologies,
                selectedValues: _technologies,
                labelBuilder: (s) => s,
                onChanged: (val) => setState(() => _technologies = val),
              ),
              const SizedBox(height: 16),
              SearchableMultiChoiceField<String>(
                label: 'Required Languages',
                values: DataService.languages,
                selectedValues: _languages,
                labelBuilder: (s) => s,
                onChanged: (val) => setState(() => _languages = val),
              ),
              const SizedBox(height: 32),

              Text("Conditions", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Monthly Salary (\$)',
                initialValue: _salary,
                onChanged: (val) => setState(() => _salary = val ?? 0),
                validator: (val) => val == null || val.isEmpty ? 'Please enter salary' : null,
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Working Hours per Week',
                initialValue: _hours,
                onChanged: (val) => setState(() => _hours = val ?? 40),
                validator: (val) => val == null || val.isEmpty ? 'Please enter working hours' : null,
              ),
              const SizedBox(height: 16),
              SingleChoiceField<EmploymentType>(
                label: 'Employment Type',
                value: _employment,
                items: EmploymentType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
                onChanged: (val) => setState(() => _employment = val ?? EmploymentType.fullTime),
              ),
              const SizedBox(height: 16),
              SingleChoiceField<LocationType>(
                label: 'Work Location',
                value: _location,
                items: LocationType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
                onChanged: (val) => setState(() => _location = val ?? LocationType.remote),
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
                    : const Text('Post Vacancy', style: TextStyle(fontSize: 18)),
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

    setState(() => _isPublishing = true);
    
    try {
      final vacancy = Vacancy(
        id: 0,
        title: _title,
        description: _description,
        companyID: _companyID,
        companyName: _companyName,
        experience: _experience,
        salary: _salary,
        hours: _hours,
        employment: _employment,
        location: _location,
        languages: _languages,
        technologies: _technologies,
      );
      
      await ApiService().createVacancy(vacancy);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vacancy posted successfully!")));
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
