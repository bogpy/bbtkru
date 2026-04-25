import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';

class VacancyProfilePage extends ConsumerStatefulWidget {
  final int id;
  const VacancyProfilePage({super.key, required this.id});

  @override
  ConsumerState<VacancyProfilePage> createState() => _VacancyProfilePageState();
}

class _VacancyProfilePageState extends ConsumerState<VacancyProfilePage> {
  late Future<Vacancy> _vacancyFuture;

  @override
  void initState() {
    super.initState();
    _vacancyFuture = ApiService().getVacancy(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Vacancy Details'),
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
      body: FutureBuilder<Vacancy>(
        future: _vacancyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Vacancy not found.'));
          }

          final vacancy = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(context, vacancy),
                const SizedBox(height: 24),
                _buildJobDetails(context, vacancy),
                const SizedBox(height: 24),
                _buildDescription(context, vacancy),
                const SizedBox(height: 24),
                _buildSkillSection(context, "Required Technologies", vacancy.technologies, Colors.blue),
                const SizedBox(height: 16),
                _buildSkillSection(context, "Required Languages", vacancy.languages, Colors.green),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, Vacancy vacancy) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vacancy.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/company', arguments: vacancy.companyID),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.business, size: 20, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text(
                    vacancy.companyName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobDetails(BuildContext context, Vacancy vacancy) {
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
            _buildDetailRow(Icons.attach_money, "Monthly Salary", "\$${vacancy.salary}", Colors.green),
            const Divider(height: 24),
            _buildDetailRow(Icons.location_on, "Location", vacancy.location.displayName, Colors.redAccent),
            const Divider(height: 24),
            _buildDetailRow(Icons.access_time, "Employment", vacancy.employment.displayName, Colors.orange),
            const Divider(height: 24),
            _buildDetailRow(Icons.work_history, "Experience", "${vacancy.experience} years", Colors.blue),
            const Divider(height: 24),
            _buildDetailRow(Icons.timer, "Weekly Hours", "${vacancy.hours}h", Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Vacancy vacancy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 12),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                vacancy.description,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ),
        ),
      ],
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => Chip(
            label: Text(skill),
            backgroundColor: color.withValues(alpha: 0.1),
            labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )).toList(),
        ),
      ],
    );
  }
}
