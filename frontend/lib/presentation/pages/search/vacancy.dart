import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/vacancy.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';
import 'package:headless_hunter_frontend/logic/search_providers.dart';

class VacancySearchPage extends ConsumerStatefulWidget {
  const VacancySearchPage({super.key});

  @override
  ConsumerState<VacancySearchPage> createState() => _VacancySearchPageState();
}

class _VacancySearchPageState extends ConsumerState<VacancySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isPanelExpanded;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(vacancySearchTextProvider);
  }

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
    final request = ref.watch(vacancyRequestProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              ref.read(vacancyRequestProvider.notifier).reset();
              ref.read(vacancySearchTextProvider.notifier).reset();
              _searchController.clear();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Filters'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by title',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              ref.read(vacancySearchTextProvider.notifier).update(value);
            },
          ),
          const SizedBox(height: 20),
          Text("Filters", style: Theme.of(context).textTheme.titleMedium),
          const Divider(),
          const SizedBox(height: 10),
          NumericTextFormField(
            label: 'Minimum Experience (years)',
            initialValue: request.experience,
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(experience: val));
            },
          ),
          const SizedBox(height: 16),
          NumericTextFormField(
            label: 'Minimum Monthly Salary (\$)',
            initialValue: request.salary,
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(salary: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<EmploymentType>(
            label: 'Employment Type',
            value: request.employment,
            items: EmploymentType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(employment: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<LocationType>(
            label: 'Preferred Location',
            value: request.location,
            items: LocationType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))).toList(),
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(location: val));
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'Country',
            initialValue: request.country,
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(country: val));
            },
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Technologies',
            values: DataService.technologies,
            selectedValues: request.technologies,
            labelBuilder: (s) => s,
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(technologies: val));
            },
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Languages',
            values: DataService.languages,
            selectedValues: request.languages,
            labelBuilder: (s) => s,
            onChanged: (val) {
              ref.read(vacancyRequestProvider.notifier).update(request.copyWith(languages: val));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVacancyResults() {
    final vacancyAsync = ref.watch(vacanciesProvider);
    final searchText = ref.watch(vacancySearchTextProvider);

    return vacancyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (items) {
        final filtered = items
            .where((i) => i.title.toLowerCase().contains(searchText.toLowerCase()))
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

