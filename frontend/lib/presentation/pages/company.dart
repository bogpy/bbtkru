import 'models/company.dart';

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
