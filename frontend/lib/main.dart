import 'package:flutter/material.dart';
import 'presentation/pages/applicant.dart';
import 'presentation/pages/company.dart';
import 'presentation/pages/vacancy.dart';

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
        '/search_applicant': (context) => const ApplicantSearchPage(),
        '/search_vacancy': (context) => const VacancySearchPage(),
        '/search_company': (context) => const CompanySearchPage(),
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
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/search_applicant'),
              icon: const Icon(Icons.person),
              label: const Text('Find your next Employee of the Month'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/search_vacancy'),
              icon: const Icon(Icons.money),
              label: const Text('Find your Dream Job'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/search_company'),
              icon: const Icon(Icons.business),
              label: const Text('Find your Dream Company'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(250, 50)),
            ),
          ],
        ),
      ),
    );
  }
}