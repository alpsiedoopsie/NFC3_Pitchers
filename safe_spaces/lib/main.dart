import 'package:flutter/material.dart';
import 'package:safe_spaces/emergency_contact_screen.dart';
import 'package:safe_spaces/registerscreen.dart';
import 'splashscreen.dart';
import 'onboardingscreen.dart';
import 'authscreen.dart';
import 'mainscreen.dart';
import 'incidentreportingscreen.dart';
import 'realtimeupdatesscreen.dart';
import 'lawenforcementinterface.dart';
import 'settingsscreen.dart';
import 'profilesettingsscreen.dart';
import 'notificationsettingsscreen.dart';
import 'languagesettingsscreen.dart';
import 'privacysettingsscreen.dart';
import 'helpandsupportscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/auth': (context) => AuthScreen(),
        '/main': (context) => MainScreen(),
        '/report': (context) => IncidentReportingScreen(),
        '/updates': (context) => RealTimeUpdatesScreen(),
        '/admin': (context) => LawEnforcementInterface(),
        '/settings': (context) => SettingsScreen(),
        '/profile-settings': (context) => ProfileSettingsScreen(),
        '/notification-settings': (context) => NotificationSettingsScreen(),
        '/language-settings': (context) => LanguageSettingsScreen(),
        '/privacy-settings': (context) => PrivacySettingsScreen(),
        '/help-support': (context) => HelpAndSupportScreen(),
        '/register': (context) => RegisterScreen(),
        '/contacts': (context) => EmergencyContactScreen(),
      },
    );
  }
}
