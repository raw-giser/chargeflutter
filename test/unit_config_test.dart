import 'package:test/test.dart';
import '../lib/config.dart';


void main(){
  group("config", (){
      test('serverHost shold be http://evzhuangjia.tmaps.cn/chargeNow_test/', (){
        expect(SERVER_HOST, 'http://evzhuangjia.tmaps.cn/chargeNow_test/');
      });
      test('serverName shold be daimler/', (){
        expect(SERVER_NAME, 'daimler/');
      });
  });
}