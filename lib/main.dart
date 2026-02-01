import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunu_moulin_smarteco/config/theme.dart';
import 'package:sunu_moulin_smarteco/config/router.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/services/storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  runApp(
    // ProviderScope est nécessaire pour que Riverpod fonctionne dans toute l'application.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Widget racine de l'application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    // ScreenUtilInit permet de rendre l'interface utilisateur responsive.
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Taille de design de référence (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Sunu Moulin SmartEco',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system, // Utilise le thème du système
          locale: locale,
          localeListResolutionCallback: (locales, supported) {
            if (locales == null || locales.isEmpty) return supported.first;
            for (final loc in locales) {
              for (final s in supported) {
                if (s.languageCode == loc.languageCode && (s.countryCode == null || s.countryCode == loc.countryCode)) {
                  return s;
                }
              }
            }
            return supported.first;
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FallbackMaterialLocalizationsDelegate(),
            FallbackCupertinoLocalizationsDelegate(),
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

class FallbackMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'wo';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return await GlobalMaterialLocalizations.delegate.load(const Locale('fr'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class FallbackCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'wo';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return await GlobalCupertinoLocalizations.delegate.load(const Locale('fr'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}
