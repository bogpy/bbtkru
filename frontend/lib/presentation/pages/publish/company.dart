import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/company.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';

class PublishCompanyPage extends ConsumerStatefulWidget {
  const PublishCompanyPage({super.key});

  @override
  ConsumerState<PublishCompanyPage> createState() => _PublishCompanyPageState();
}

class _PublishCompanyPageState extends ConsumerState<PublishCompanyPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _name = '';
  String _country = '';
  int _yearFound = DateTime.now().year;
  int _employeeCount = 0;

  bool _isPublishing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Create Company Profile'),
        actions: [
          IconButton(
            icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Information", style: Theme.of(context).textTheme.headlineSmall),
              const Divider(),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Company Name',
                onChanged: (val) => setState(() => _name = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter company name' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Country',
                onChanged: (val) => setState(() => _country = val),
                validator: (val) => val == null || val.isEmpty ? 'Please enter country' : null,
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Year Founded',
                initialValue: _yearFound,
                onChanged: (val) => setState(() => _yearFound = val ?? DateTime.now().year),
                validator: (val) => val == null || val.isEmpty ? 'Please enter founding year' : null,
              ),
              const SizedBox(height: 16),
              NumericTextFormField(
                label: 'Total Employees',
                initialValue: _employeeCount,
                onChanged: (val) => setState(() => _employeeCount = val ?? 0),
                validator: (val) => val == null || val.isEmpty ? 'Please enter employee count' : null,
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
                    : const Text('Create Profile', style: TextStyle(fontSize: 18)),
                ),
              ),
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
      final company = Company(
        id: 0,
        name: _name,
        country: _country,
        yearFound: _yearFound,
        employeeCount: _employeeCount,
        vacancies: [],
      );
      
      await ApiService().createCompany(company);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Company profile created successfully!")));
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
