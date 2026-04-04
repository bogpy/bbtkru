import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/services/api_service.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';

class VacancySearchPage extends ConsumerStatefulWidget {
  const VacancySearchPage({super.key});

  @override
  ConsumerState<VacancySearchPage> createState() => _VacancySearchPageState();
}

class _VacancySearchPageState extends ConsumerState<VacancySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isPanelExpanded;
  RequestForVacancy _request = const RequestForVacancy();

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
            const Text('Search Vacancies'),
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
              child: SingleChildScrollView(child: _buildVacancySearchBar()),
            ),
          if (isExpanded) const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: _buildVacancyResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildVacancySearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by title',
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
          NumericTextFormField(
            label: 'Minimum Monthly Salary (\$)',
            initialValue: _request.salary,
            onChanged: (val) => setState(() => _request = _request.copyWith(salary: val)),
          ),
          const SizedBox(height: 16),
          SingleChoiceField<EmploymentType>(
            label: 'Employment Type',
            value: _request.employment,
            items: EmploymentType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
            onChanged: (val) => setState(() => _request = _request.copyWith(employment: val)),
          ),
          const SizedBox(height: 16),
          SingleChoiceField<LocationType>(
            label: 'Preferred Location',
            value: _request.location,
            items: LocationType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
            onChanged: (val) => setState(() => _request = _request.copyWith(location: val)),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Country',
            initialValue: _request.country,
            onChanged: (val) => setState(() => _request = _request.copyWith(country: val)),
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Technologies',
            values: DataService.technologies,
            selectedValues: _request.technologies,
            labelBuilder: (s) => s,
            onChanged: (val) => setState(() => _request = _request.copyWith(technologies: val)),
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Languages',
            values: DataService.languages,
            selectedValues: _request.languages,
            labelBuilder: (s) => s,
            onChanged: (val) => setState(() => _request = _request.copyWith(languages: val)),
          ),
        ],
      ),
    );
  }

  Widget _buildVacancyResults() {
    return FutureBuilder<List<Vacancy>>(
      future: ApiService().getVacancies(_request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        final filtered = items
            .where((i) => i.title.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("No vacancies found matching filters."));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              leading: const Icon(Icons.work_outline),
              title: Text(item.title),
              subtitle: Text("${item.companyName} • ${item.location.displayName} • \$${item.salary}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => Navigator.pushNamed(context, '/vacancy', arguments: item.id),
            );
          },
        );
      },
    );
  }
}
