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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Vacancy Details'),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vacancy.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/company', arguments: vacancy.companyID),
                  child: Text(
                    vacancy.companyName,
                    style: const TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
                const Divider(height: 40),
                InfoRow(icon: Icons.attach_money, label: "Monthly Salary", value: "\$${vacancy.salary}"),
                InfoRow(icon: Icons.location_on, label: "Work Location", value: vacancy.location.displayName),
                InfoRow(icon: Icons.access_time, label: "Employment Type", value: vacancy.employment.displayName),
                InfoRow(icon: Icons.work_history, label: "Minimum Experience", value: "${vacancy.experience} years"),
                InfoRow(icon: Icons.timer, label: "Working Hours per Week", value: vacancy.hours.toString()),
                const SizedBox(height: 20),
                const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Text(vacancy.description),
                const SizedBox(height: 20),
                const Text("Required Technologies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: vacancy.technologies.map((tech) => Chip(
                    label: Text(tech),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Languages", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: vacancy.languages.map((lang) => Chip(
                    label: Text(lang),
                    backgroundColor: Colors.green.withValues(alpha: 0.1),
                  )).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
