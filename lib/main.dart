import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- FIREBASE IMPORTS ---
// We need these to initialize the app
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // The file you created!

// --- APP FILE IMPORTS ---
import 'home_screen.dart';
import 'dashboard_view_model.dart';

// The main() function is now 'async'
void main() async {
  // This ensures that all Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // --- THIS IS THE FIX ---
  // We are now initializing Firebase using your unique firebase_options.dart
  // and 'await'ing it (waiting) until it's done.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // After Firebase is ready, we run the app.
  runApp(const EcoPilotApp());
}

class EcoPilotApp extends StatelessWidget {
  const EcoPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We provide the DashboardViewModel to the entire app.
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(),
      child: MaterialApp(
        title: 'Eco-Pilot',
        theme: ThemeData(
          // --- App Theme ---
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.green[800],
          scaffoldBackgroundColor: Colors.grey[100],
          
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.green[900],
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.green[900]),
          ),
          
          cardTheme: CardThemeData( // Changed to CardThemeData
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

