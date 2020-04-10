import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localestringmodule/text_localizations_delegate.dart';

class LocaleConfig {
  static Locale localeDefault() => supportedLocales().toList()[0];

  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates() => [
        const TextLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static Iterable<Locale> supportedLocales() =>
      [const Locale('en', ''), const Locale('ja', ''), const Locale('vi', '')];
}
