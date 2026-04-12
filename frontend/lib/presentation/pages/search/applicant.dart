import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/models/applicant.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';
import 'package:headless_hunter_frontend/logic/search_providers.dart';

class ApplicantSearchPage extends ConsumerStatefulWidget {
  const ApplicantSearchPage({super.key});

  @override
  ConsumerState<ApplicantSearchPage> createState() => _ApplicantSearchPageState();
}

class _ApplicantSearchPageState extends ConsumerState<ApplicantSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isPanelExpanded;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(applicantSearchTextProvider);
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
    final request = ref.watch(applicantRequestProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by title',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              ref.read(applicantSearchTextProvider.notifier).update(value);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filters", style: Theme.of(context).textTheme.titleMedium),
              TextButton.icon(
                onPressed: () {
                  ref.read(applicantRequestProvider.notifier).reset();
                  ref.read(applicantSearchTextProvider.notifier).reset();
                  _searchController.clear();
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reset'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          NumericTextFormField(
            label: 'Minimum Experience (years)',
            initialValue: request.experience,
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(experience: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<LevelType>(
            label: 'Target Level',
            value: request.level,
            items: [
              const DropdownMenuItem(value: null, child: Text('None')),
              ...LevelType.values.map((l) => DropdownMenuItem(value: l, child: Text(l.displayName))),
            ],
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(level: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<SpecialtyType>(
            label: 'Core Specialty',
            value: request.specialty,
            items: [
              const DropdownMenuItem(value: null, child: Text('None')),
              ...SpecialtyType.values.map((s) => DropdownMenuItem(value: s, child: Text(s.displayName))),
            ],
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(specialty: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<EducationType>(
            label: 'Minimum Education',
            value: request.education,
            items: [
              const DropdownMenuItem(value: null, child: Text('None')),
              ...EducationType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))),
            ],
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(education: val));
            },
          ),
          const SizedBox(height: 16),
          SingleChoiceField<bool?>(
            label: 'Graduated',
            value: request.graduated,
            items: const [
              DropdownMenuItem(value: null, child: Text('None')),
              DropdownMenuItem(value: false, child: Text('False')),
              DropdownMenuItem(value: true, child: Text('True')),
            ],
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(graduated: val));
            },
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Technologies',
            values: DataService.technologies,
            selectedValues: request.technologiesRequired,
            labelBuilder: (s) => s,
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(technologiesRequired: val));
            },
          ),
          const SizedBox(height: 16),
          SearchableMultiChoiceField<String>(
            label: 'Languages',
            values: DataService.languages,
            selectedValues: request.languagesRequired,
            labelBuilder: (s) => s,
            onChanged: (val) {
              ref.read(applicantRequestProvider.notifier).update(request.copyWith(languagesRequired: val));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantResults() {
    final applicantAsync = ref.watch(applicantsProvider);
    final searchText = ref.watch(applicantSearchTextProvider);

    return applicantAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (items) {
        final filtered = items
            .where((i) => i.name.toLowerCase().contains(searchText.toLowerCase()))
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

