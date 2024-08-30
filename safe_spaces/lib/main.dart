import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locale_provider.dart';
import 'l10n.dart';
import 'splashscreen.dart';
import 'onboardingscreen.dart';
import 'authscreen.dart';
import 'mainscreen.dart';
import 'incidentreportingscreen.dart';
import 'lawenforcementinterface.dart';
import 'settingsscreen.dart';
import 'profilesettingsscreen.dart';
import 'notificationsettingsscreen.dart';
import 'languagesettingsscreen.dart';
import 'privacysettingsscreen.dart';
import 'helpandsupportscreen.dart';
import 'registerscreen.dart';
import 'emergency_contact_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Multilingual App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: provider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/onboarding': (context) => OnboardingScreen(),
              '/auth': (context) => AuthScreen(),
              '/main': (context) => MainScreen(),
              '/report': (context) => IncidentReportingScreen(),
              '/admin': (context) => LawEnforcementInterface(),
              '/settings': (context) => SettingsScreen(),
              '/profile-settings': (context) => ProfileSettingsScreen(),
              '/notification-settings': (context) =>
                  NotificationSettingsScreen(),
              '/language-settings': (context) => LanguageSettingsScreen(),
              '/privacy-settings': (context) => PrivacySettingsScreen(),
              '/help-support': (context) => HelpAndSupportScreen(),
              '/register': (context) => RegisterScreen(),
              '/contacts': (context) => EmergencyContactScreen(),
            },
          );
        },
      ),
    );
  }
}
