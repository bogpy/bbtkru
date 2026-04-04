import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';

class ApplicantProfilePage extends ConsumerStatefulWidget {
  final int id;
  const ApplicantProfilePage({super.key, required this.id});

  @override
  ConsumerState<ApplicantProfilePage> createState() => _ApplicantProfilePageState();
}

class _ApplicantProfilePageState extends ConsumerState<ApplicantProfilePage> {
  late Future<Applicant> _applicantFuture;

  @override
  void initState() {
    super.initState();
    _applicantFuture = ApiService().getApplicant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Applicant Profile'),
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
      body: FutureBuilder<Applicant>(
        future: _applicantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Applicant not found.'));
          }

          final applicant = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(applicant.name[0], style: const TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    applicant.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Divider(height: 40),
                InfoRow(icon: Icons.school, label: "Education", value: applicant.education.displayName),
                InfoRow(icon: Icons.business, label: "Specialty", value: applicant.specialty.displayName),
                InfoRow(icon: Icons.trending_up, label: "Level", value: applicant.level.displayName),
                InfoRow(icon: Icons.work, label: "Experience", value: "${applicant.experience} years"),
                const SizedBox(height: 20),
                const Text("Technologies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: applicant.technologies.map((tech) => Chip(
                    label: Text(tech),
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Work History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(applicant.workHistory),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
