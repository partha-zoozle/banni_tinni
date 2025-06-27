import 'package:flutter/material.dart';
import 'package:banni_tinni/core/theme/app_theme.dart';
import 'package:banni_tinni/features/splash/presentation/pages/splash_screen.dart';
import 'package:banni_tinni/features/home/presentation/pages/home_screen.dart';
import 'package:banni_tinni/features/history/presentation/pages/history_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banni Tinni',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
