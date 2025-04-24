import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/auth/auth_wrapper.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'ConnectiWork',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        supportedLocales: const [
          Locale('en'), // English
          Locale('fr'), // French
          Locale('ar'), // Arabic
          Locale('es'), // Spanish
        ],
        home: const AuthWrapper(),
      ),
    );
  }
}
