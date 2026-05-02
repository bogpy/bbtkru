import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/company.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';

class CompanyProfilePage extends ConsumerStatefulWidget {
  final int id;
  const CompanyProfilePage({super.key, required this.id});

  @override
  ConsumerState<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends ConsumerState<CompanyProfilePage> {
  late Future<(Company, List<Vacancy>)> _companyDataFuture;

  @override
  void initState() {
    super.initState();
    _companyDataFuture = _fetchData();
  }

  Future<(Company, List<Vacancy>)> _fetchData() async {
    final results = await Future.wait([
      ApiService().getCompany(widget.id),
      ApiService().getCompanyVacancies(widget.id),
    ]);
    return (results[0] as Company, results[1] as List<Vacancy>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Company Profile'),
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
      body: FutureBuilder<(Company, List<Vacancy>)>(
        future: _companyDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Company not found.'));
          }

          final (company, vacancies) = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, company),
                const SizedBox(height: 24),
                _buildDetails(context, company),
                const SizedBox(height: 32),
                _buildVacanciesSection(context, vacancies),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Company company) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  company.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              company.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 16, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  company.country,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, Company company) {
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
            InfoRow(
              icon: Icons.calendar_today,
              label: "Year Founded",
              value: company.yearFound.toString(),
              iconColor: Colors.orange,
            ),
            const Divider(height: 24),
            InfoRow(
              icon: Icons.people,
              label: "Total Employees",
              value: company.employeeCount.toString(),
              iconColor: Colors.blue,
            ),
            const Divider(height: 24),
            InfoRow(
              icon: Icons.star,
              label: "Company Score",
              value: company.score.toString(),
              iconColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVacanciesSection(BuildContext context, List<Vacancy> vacancies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16),
          child: Row(
            children: [
              const Text(
                "Active Vacancies",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vacancies.length.toString(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        if (vacancies.isEmpty)
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.work_off_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      "No open vacancies at the moment.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vacancies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final vacancy = vacancies[index];
              return Card(
                elevation: 2,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Text(
                    vacancy.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(vacancy.location.displayName),
                        const SizedBox(width: 12),
                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(vacancy.employment.displayName),
                      ],
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/vacancy', arguments: vacancy.id),
                ),
              );
            },
          ),
      ],
    );
  }
}
