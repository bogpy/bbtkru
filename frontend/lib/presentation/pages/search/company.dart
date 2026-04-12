import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/presentation/widgets/forms.dart';
import 'package:headless_hunter_frontend/logic/search_providers.dart';

class CompanySearchPage extends ConsumerStatefulWidget {
  const CompanySearchPage({super.key});

  @override
  ConsumerState<CompanySearchPage> createState() => _CompanySearchPageState();
}

class _CompanySearchPageState extends ConsumerState<CompanySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool? _isPanelExpanded;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(companySearchTextProvider);
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
            const Text('Search Companies'),
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
              child: SingleChildScrollView(child: _buildCompanySearchBar()),
            ),
          if (isExpanded) const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: _buildCompanyResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanySearchBar() {
    final request = ref.watch(companyRequestProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              ref.read(companySearchTextProvider.notifier).update(value);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filters", style: Theme.of(context).textTheme.titleMedium),
              TextButton.icon(
                onPressed: () {
                  ref.read(companyRequestProvider.notifier).reset();
                  ref.read(companySearchTextProvider.notifier).reset();
                  _searchController.clear();
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reset'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Operating Country',
            initialValue: request.country,
            onChanged: (val) {
              ref.read(companyRequestProvider.notifier).update(request.copyWith(country: val));
            },
          ),
          const SizedBox(height: 16),
          NumericTextFormField(
            label: 'Minimum Employee Count',
            initialValue: request.employeeCount,
            onChanged: (val) {
              ref.read(companyRequestProvider.notifier).update(request.copyWith(employeeCount: val));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyResults() {
    final companyAsync = ref.watch(companiesProvider);
    final searchText = ref.watch(companySearchTextProvider);

    return companyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (items) {
        final filtered = items
            .where((i) => i.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();

        if (filtered.isEmpty) {
          return const Center(child: Text("No companies found matching filters."));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final item = filtered[index];
            return ListTile(
              leading: CircleAvatar(child: Text(item.name[0])),
              title: Text(item.name),
              subtitle: Text("${item.country} • ${item.employeeCount} employees"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => Navigator.pushNamed(context, '/company', arguments: item.id),
            );
          },
        );
      },
    );
  }
}

