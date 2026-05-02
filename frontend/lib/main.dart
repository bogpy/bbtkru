import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:headless_hunter_frontend/core/theme_provider.dart';
import 'package:headless_hunter_frontend/presentation/pages/profile/applicant.dart';
import 'package:headless_hunter_frontend/presentation/pages/profile/company.dart';
import 'package:headless_hunter_frontend/presentation/pages/profile/vacancy.dart';
import 'package:headless_hunter_frontend/presentation/pages/search/applicant.dart';
import 'package:headless_hunter_frontend/presentation/pages/search/company.dart';
import 'package:headless_hunter_frontend/presentation/pages/search/vacancy.dart';
import 'package:headless_hunter_frontend/presentation/pages/publish/applicant.dart';
import 'package:headless_hunter_frontend/presentation/pages/publish/company.dart';
import 'package:headless_hunter_frontend/presentation/pages/publish/vacancy.dart';
import 'package:headless_hunter_frontend/services/data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataService.loadData();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => Listener(
        onPointerDown: (event) {
          // 8 is the standard bitmask for the "back" button on most mice
          if (event.kind == PointerDeviceKind.mouse && event.buttons == kBackMouseButton) {
            navigatorKey.currentState?.maybePop();
          }
        },
        child: child!,
      ),
      title: 'HeadlessHunter',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7AA2F7),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7AA2F7),
          secondary: Color(0xFFBB9AF7),
          surface: Color(0xFF24283B),
          error: Color(0xFFF7768E),
          onPrimary: Color(0xFF1A1B26),
          onSecondary: Color(0xFF1A1B26),
          onSurface: Color(0xFFC0CAF5),
          onError: Color(0xFF1A1B26),
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1B26),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F2335),
          foregroundColor: Color(0xFFC0CAF5),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/search_applicant': (context) => const ApplicantSearchPage(),
        '/search_vacancy': (context) => const VacancySearchPage(),
        '/search_company': (context) => const CompanySearchPage(),
        '/publish_applicant': (context) => const PublishApplicantPage(),
        '/publish_vacancy': (context) => const PublishVacancyPage(),
        '/publish_company': (context) => const PublishCompanyPage(),
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

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('HeadlessHunter'),
        actions: [
          IconButton(
            icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Welcome to HeadlessHunter',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isDesktop = constraints.maxWidth > 1000;
                  
                  final searchSection = Column(
                    children: [
                      Text("I am looking for...", style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/search_applicant'),
                        icon: const Icon(Icons.person, size: 28),
                        label: const Text('My Dream Employee', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/search_vacancy'),
                        icon: const Icon(Icons.money, size: 28),
                        label: const Text('My Dream Job', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/search_company'),
                        icon: const Icon(Icons.business, size: 28),
                        label: const Text('My Dream Company', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ],
                  );

                  final publishSection = Column(
                    children: [
                      Text("I want to publish...", style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/publish_applicant'),
                        icon: const Icon(Icons.description, size: 28),
                        label: const Text('My Resume', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/publish_vacancy'),
                        icon: const Icon(Icons.add_task, size: 28),
                        label: const Text('A New Vacancy', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/publish_company'),
                        icon: const Icon(Icons.add_business, size: 28),
                        label: const Text('A Company Profile', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 80),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ],
                  );

                  if (isDesktop) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchSection,
                        const SizedBox(width: 60),
                        publishSection,
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        searchSection,
                        const SizedBox(height: 60),
                        publishSection,
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
