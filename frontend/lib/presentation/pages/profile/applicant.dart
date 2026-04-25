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
        title: const Text('Applicant Profile'),
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
      body: FutureBuilder<Applicant>(
        future: _applicantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Applicant not found.'));
          }

          final applicant = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, applicant),
                const SizedBox(height: 24),
                _buildInfoSection(context, applicant),
                const SizedBox(height: 24),
                _buildSkillSection(context, "Technologies", applicant.technologies, Colors.blue),
                const SizedBox(height: 16),
                _buildSkillSection(context, "Languages", applicant.languages, Colors.green),
                const SizedBox(height: 24),
                _buildWorkHistory(context, applicant),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Applicant applicant) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  applicant.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              applicant.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                applicant.specialty.displayName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Applicant applicant) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InfoRow(icon: Icons.school, label: "Education", value: applicant.education.displayName),
            const Divider(height: 24),
            InfoRow(icon: Icons.trending_up, label: "Level", value: applicant.level.displayName),
            const Divider(height: 24),
            InfoRow(icon: Icons.work, label: "Experience", value: "${applicant.experience} years"),
            const Divider(height: 24),
            InfoRow(icon: Icons.location_city, label: "University", value: applicant.university),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(BuildContext context, String title, List<String> skills, Color color) {
    if (skills.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => Chip(
            label: Text(skill),
            side: BorderSide.none,
            backgroundColor: color.withValues(alpha: 0.1),
            labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildWorkHistory(BuildContext context, Applicant applicant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "Work History",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                applicant.workHistory.isEmpty ? "No work history provided." : applicant.workHistory,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
