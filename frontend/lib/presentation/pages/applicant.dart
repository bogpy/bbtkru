import 'package:flutter/material.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Applicants')),
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.grey[100],
            child: _buildApplicantSearchBar(),
          ),
          VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: _buildApplicantResults(),
          ),
        ],
      )
    );
  }

  Widget _buildApplicantSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          // Additional filters can be added here
        ],
      ),
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

  