import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/utils/app_localization.dart';
import 'core/utils/app_router.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_data.dart';

class LocaleManager {
  static Locale currentLocale = Locale(SharedData.getUserLan() ?? 'en');

  static void setLocale(BuildContext context, Locale newLocale) {
    currentLocale = newLocale;
    // Rebuild the widget tree when the locale changes
    runApp(MyApp());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedData.init();
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     return MaterialApp.router(
      locale: LocaleManager.currentLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('ru'),
        Locale('de'),
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.grey,
      ),
    );
  }
}

//w = 480.0, h= 1034.0
