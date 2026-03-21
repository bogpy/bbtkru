import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/applicant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeadlessHunter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'HeadlessHunter | Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final api = ApiService();

  late Future<Applicant> _applicantFuture;

  @override
  void initState() {
    super.initState();
    // Fetching single applicant from your Go backend
    _applicantFuture = ApiService().getApplicant(12);
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
                // Header Section
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

                // Details Grid or List
                _buildInfoRow(Icons.school, "Education", applicant.education.name),
                _buildInfoRow(Icons.business, "Specialty", applicant.specialty.name),
                _buildInfoRow(Icons.trending_up, "Level", applicant.level.name),
                _buildInfoRow(Icons.work, "Experience", "${applicant.experience} years"),
                
                const SizedBox(height: 20),
                const Text("Technologies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                
                // Displaying the list of technologies
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
