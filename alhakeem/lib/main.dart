import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/ambulance_screen.dart';
import 'screens/doctor_consultation.dart';
import 'screens/lab_test_screen.dart';
import 'screens/medicine_search_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/nurse_request_screen.dart';
import 'screens/physical_therapy_screen.dart';
import 'screens/ct_mri_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/ambulance': (context) => AmbulanceScreen(),
        '/doctor': (context) => DoctorChatScreen(),
        '/lab': (context) => LabTestScreen(),
        '/medicine': (context) => MedicineSearchScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        '/nurse': (context) => NurseRequestScreen(),
        '/therapy': (context) => PhysicalTherapyScreen(),
        '/imaging': (context) => CtMriScreen(),
      },
    );
  }
}
