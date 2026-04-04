import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';

class ApplicantSearchPage extends ConsumerStatefulWidget {
  const ApplicantSearchPage({super.key});

  @override
  ConsumerState<ApplicantSearchPage> createState() => _ApplicantSearchPageState();
}

class _ApplicantSearchPageState extends ConsumerState<ApplicantSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isPanelExpanded;
  RequestForApplicant _request = const RequestForApplicant();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool shouldExpand = width > 900;
    final bool isExpanded = _isPanelExpanded ?? shouldExpand;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Search Applicants'),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
              tooltip: isExpanded ? 'Fold Filter' : 'Expand Filter',
              onPressed: () {
                setState(() {
                  _isPanelExpanded = !isExpanded;
                });
              },
            ),
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
      body: Row(
        children: [
          if (isExpanded)
            Container(
              width: 320,
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: SingleChildScrollView(child: _buildApplicantSearchBar()),
            ),
          if (isExpanded) const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: _buildApplicantResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 20),
          Text("Filters", style: Theme.of(context).textTheme.titleMedium),
          const Divider(),
          const SizedBox(height: 10),
          NumericTextFormField(
            label: 'Minimum Experience (years)',
            initialValue: _request.experience,
            onChanged: (val) => setState(() => _request = _request.copyWith(experience: val)),
          ),
          const SizedBox(height: 16),
          SingleChoiceField<LevelType>(
            label: 'Target Level',
            value: _request.level,
            items: LevelType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
            onChanged: (val) => setState(() => _request = _request.copyWith(level: val)),
          ),
          const SizedBox(height: 16),
          SingleChoiceField<SpecialtyType>(
            label: 'Core Specialty',
            value: _request.specialty,
            items: SpecialtyType.values.map((s) => DropdownMenuItem(value: s, child: Text(s.displayName))).toList(),
            onChanged: (val) => setState(() => _request = _request.copyWith(specialty: val)),
          ),
          const SizedBox(height: 16),
          SingleChoiceField<EducationType>(
            label: 'Minimum Education',
            value: _request.education,
            items: EducationType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
            onChanged: (val) => setState(() => _request = _request.copyWith(education: val)),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text("Graduated"),
            value: _request.graduated ?? false,
            onChanged: (val) => setState(() => _request = _request.copyWith(graduated: val)),
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Technologies',
            values: DataService.technologies,
            selectedValues: _request.technologiesRequired,
            labelBuilder: (s) => s,
            onChanged: (val) => setState(() => _request = _request.copyWith(technologiesRequired: val)),
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Languages',
            values: DataService.languages,
            selectedValues: _request.languagesRequired,
            labelBuilder: (s) => s,
            onChanged: (val) => setState(() => _request = _request.copyWith(languagesRequired: val)),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantResults() {
    return FutureBuilder<List<Applicant>>(
      future: ApiService().getApplicants(_request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        final filtered = items
            .where((i) => i.name.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("No applicants found matching filters."));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              leading: CircleAvatar(child: Text(item.name[0])),
              title: Text(item.name),
              subtitle: Text("${item.specialty.displayName} • ${item.level.displayName} • ${item.experience} yrs"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => Navigator.pushNamed(context, '/applicant', arguments: item.id),
            );
          },
        );
      },
    );
  }
}
