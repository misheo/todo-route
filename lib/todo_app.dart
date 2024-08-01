import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/theme/app_theme.dart';

import 'core/helper/cash.dart';
import 'provider/settings_provider.dart';
import 'screens/main_screen.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    super.initState();
    initLocals();
  }

  Future<void> initLocals() async {
    String? lang = await Cash().getSelectedLanguage();
    debugPrint('InitLocals: Setting language to $lang');
    Provider.of<SettingsProvider>(context, listen: false).changeLanguage(lang ?? 'en');
    int? theme = await Cash().getSelectedTheme();
    debugPrint('InitLocals: Setting theme to $theme');
    Provider.of<SettingsProvider>(context, listen: false)
        .changeThemeMode(theme == 0 ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: provider.themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          locale: Locale(provider.language),
          routes: {
            '/': (context) => const MainScreen(),
          },
        );
      },
    );
  }
}
