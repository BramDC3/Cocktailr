import 'package:cocktailr/l10n/messages_all.dart';
import 'package:cocktailr/src/constants/app_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cocktailr/src/extensions/string_extensions.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isNullOrEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appTitle => Intl.message('Cocktailr', name: 'appTitle');
  String get welcomeText => Intl.message('Hello world!', name: 'welcomeText');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [english, dutch, french].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
