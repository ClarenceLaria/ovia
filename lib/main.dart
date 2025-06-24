import 'package:flutter/material.dart';
import 'package:ovia_app/core/notifications/daily_notifications.dart';
import 'package:ovia_app/core/notifications/notification_service.dart';
import 'package:ovia_app/screens/onboarding_screen.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  await NotificationService.init();
  await DailyNotificationService().initNotification();
  await DailyNotificationService().scheduleDailyReminder(
    id: 1,
    title: 'Don’t forget!',
    body: 'Log your mood and symptoms today 🌸',
    hour: 8,
    minute: 0,
  );
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ovia',
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ovia-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const OnboardingScreen()
        ],
      ),
    );
  }
}
