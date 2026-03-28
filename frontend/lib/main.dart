import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/applicant.dart';
import 'models/company.dart';
import 'models/vacancy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeadlessHunter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/search': (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/applicant') {
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => ApplicantProfilePage(id: id),
          );
        }
        if (settings.name == '/company') {
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => CompanyProfilePage(id: id),
          );
        }
        if (settings.name == '/vacancy') {
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => VacancyProfilePage(id: id),
          );
        }
        return null;
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HeadlessHunter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to HeadlessHunter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/search'),
              icon: const Icon(Icons.search),
              label: const Text('Search Jobs & Talent'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/applicant', arguments: 1),
              icon: const Icon(Icons.person),
              label: const Text('View My Profile (Applicant 1)'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/company', arguments: 1),
              icon: const Icon(Icons.business),
              label: const Text('View Company Profile (Company 1)'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicantProfilePage extends StatefulWidget {
  final int id;
  const ApplicantProfilePage({super.key, required this.id});

  @override
  State<ApplicantProfilePage> createState() => _ApplicantProfilePageState();
}

class _ApplicantProfilePageState extends State<ApplicantProfilePage> {
  late Future<Applicant> _applicantFuture;

  @override
  void initState() {
    super.initState();
    _applicantFuture = ApiService().getApplicant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applicant Profile')),
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
                _buildInfoRow(Icons.school, "Education", applicant.education.name),
                _buildInfoRow(Icons.business, "Specialty", applicant.specialty.name),
                _buildInfoRow(Icons.trending_up, "Level", applicant.level.name),
                _buildInfoRow(Icons.work, "Experience", "${applicant.experience} years"),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

class CompanyProfilePage extends StatefulWidget {
  final int id;
  const CompanyProfilePage({super.key, required this.id});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  late Future<Company> _companyFuture;

  @override
  void initState() {
    super.initState();
    _companyFuture = ApiService().getCompany(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Profile')),
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
                _buildInfoRow(Icons.public, "Country", company.country),
                _buildInfoRow(Icons.calendar_today, "Founded", company.yearFound.toString()),
                _buildInfoRow(Icons.people, "Employees", company.employeeCount.toString()),
                const SizedBox(height: 30),
                const Text("Vacancies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                          subtitle: Text("${vacancy.location.name} • ${vacancy.employment.name}"),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

class VacancyProfilePage extends StatefulWidget {
  final int id;
  const VacancyProfilePage({super.key, required this.id});

  @override
  State<VacancyProfilePage> createState() => _VacancyProfilePageState();
}

class _VacancyProfilePageState extends State<VacancyProfilePage> {
  late Future<Vacancy> _vacancyFuture;

  @override
  void initState() {
    super.initState();
    _vacancyFuture = ApiService().getVacancy(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vacancy Details')),
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
                _buildInfoRow(Icons.attach_money, "Salary", "${vacancy.salary}"),
                _buildInfoRow(Icons.location_on, "Location", vacancy.location.name),
                _buildInfoRow(Icons.access_time, "Employment", vacancy.employment.name),
                _buildInfoRow(Icons.work_history, "Min. Experience", "${vacancy.experience} years"),
                _buildInfoRow(Icons.timer, "Hours per week", vacancy.hours.toString()),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Vacancies', icon: Icon(Icons.work)),
            Tab(text: 'Companies', icon: Icon(Icons.business)),
            Tab(text: 'Applicants', icon: Icon(Icons.people)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVacancyResults(),
                _buildCompanyResults(),
                _buildApplicantResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacancyResults() {
    final request = RequestForVacancy(
      salary: 100000,
      location: LocationType.remote,
      employment: EmploymentType.fullTime,
      experience: 15,
    );
    return FutureBuilder<List<Vacancy>>(
      future: ApiService().getVacancies(request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        final items = snapshot.data ?? [];
        final filtered = items.where((i) => i.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
        
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.companyName),
              onTap: () => Navigator.pushNamed(context, '/vacancy', arguments: item.id),
            );
          },
        );
      },
    );
  }

  Widget _buildCompanyResults() {
    final request = RequestForCompany(
      country: "USA",
      employeeCount: 100,
    );
    return FutureBuilder<List<Company>>(
      future: ApiService().getCompanies(request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        final items = snapshot.data ?? [];
        final filtered = items.where((i) => i.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.country),
              onTap: () => Navigator.pushNamed(context, '/company', arguments: item.id),
            );
          },
        );
      },
    );
  }

  Widget _buildApplicantResults() {
    final request = RequestForApplicant(
      specialty: SpecialtyType.backend,
      level: LevelType.senior,
      experience: 13,
      education: EducationType.master,
    );
    return FutureBuilder<List<Applicant>>(
      future: ApiService().getApplicants(request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        final items = snapshot.data ?? [];
        final filtered = items.where((i) => i.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text("${item.specialty.name} • ${item.level.name}"),
              onTap: () => Navigator.pushNamed(context, '/applicant', arguments: item.id),
            );
          },
        );
      },
    );
  }
}