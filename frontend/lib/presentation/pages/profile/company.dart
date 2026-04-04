import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/company.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';

class CompanyProfilePage extends ConsumerStatefulWidget {
  final int id;
  const CompanyProfilePage({super.key, required this.id});

  @override
  ConsumerState<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends ConsumerState<CompanyProfilePage> {
  late Future<Company> _companyFuture;

  @override
  void initState() {
    super.initState();
    _companyFuture = ApiService().getCompany(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Company Profile'),
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
      body: FutureBuilder<Company>(
        future: _companyFuture,
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

          final company = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(company.name[0], style: const TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    company.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Divider(height: 40),
                InfoRow(icon: Icons.public, label: "Operating Country", value: company.country),
                InfoRow(icon: Icons.calendar_today, label: "Year Founded", value: company.yearFound.toString()),
                InfoRow(icon: Icons.people, label: "Total Employees", value: company.employeeCount.toString()),
                const SizedBox(height: 30),
                const Text("Active Vacancies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const Divider(),
                if (company.vacancies.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("No open vacancies at the moment.")),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: company.vacancies.length,
                    itemBuilder: (context, index) {
                      final vacancy = company.vacancies[index];
                      return Card(
                        child: ListTile(
                          title: Text(vacancy.title),
                          subtitle: Text("${vacancy.location.displayName} • ${vacancy.employment.displayName}"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => Navigator.pushNamed(context, '/vacancy', arguments: vacancy.id),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
