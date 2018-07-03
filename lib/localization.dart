import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class ChargeLocalizations {
  ChargeLocalizations(this.locale);

  final Locale locale;

  static ChargeLocalizations of(BuildContext context) {
    return Localizations.of<ChargeLocalizations>(context, ChargeLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // 主界面
      'title': 'Charge',
      'hint': 'Search',
      // 设置界面
      'settingTitle': 'Setting',
    },
    'zh': {
      // 主界面
      'title': '桩 家',
      'hint': '搜 索',
      // 设置界面
      'settingTitle': '设置'
    }
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get hint {
    return _localizedValues[locale.languageCode]['hint'];
  }

  String get settingTitle{
    return _localizedValues[locale.languageCode]['settingTitle'];
  }
}

class ChargeLocalizationsDelegate extends LocalizationsDelegate<ChargeLocalizations> {
  const ChargeLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<ChargeLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return new SynchronousFuture<ChargeLocalizations>(new ChargeLocalizations(locale));
  }

  @override
  bool shouldReload(ChargeLocalizationsDelegate old) => false;
}
