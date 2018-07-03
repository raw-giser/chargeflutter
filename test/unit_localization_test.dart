import 'package:test/test.dart';
import 'package:flutter/material.dart';
import '../lib/localization.dart';

void main(){
  const Locale zh_CN = const Locale('zh', 'CN');
  ChargeLocalizations localization = new ChargeLocalizations(zh_CN);
  
  group('localization should have language function', (){
    test('localization should have title getter',(){
      expect(localization.title, isNot(null));
    });

    test('localization should have hint getter',(){
      expect(localization.hint, isNot(null));
    });
  });
}