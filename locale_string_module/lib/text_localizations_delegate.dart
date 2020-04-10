import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localestringmodule/locale_config.dart';

class TextLocalizations {
  final Map<String, dynamic> language;

  TextLocalizations(this.language);

  static TextLocalizations of(BuildContext context) =>
      Localizations.of<TextLocalizations>(context, TextLocalizations);

  String getText(String key) => language[key] ?? "";
}

class TextLocalizationsDelegate
    extends LocalizationsDelegate<TextLocalizations> {
  const TextLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => LocaleConfig.supportedLocales()
      .map((item) => item.languageCode)
      .toList()
      .contains(locale.languageCode);

  @override
  Future<TextLocalizations> load(Locale locale) async {
    final String string = await rootBundle
        .loadString("assets/strings/${locale.languageCode}.json");
    final language = await json.decode(string);
    return SynchronousFuture<TextLocalizations>(TextLocalizations(language));
  }

  @override
  bool shouldReload(TextLocalizationsDelegate old) => false;
}
