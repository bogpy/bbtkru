import 'models/vacancy.dart';

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