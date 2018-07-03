import 'package:test/test.dart';
import '../lib/globalSingle.dart';

void main(){
  test("globalSingle shold be singleton", (){
    GlobalVaribles globalVaribles1 = new GlobalVaribles();
    GlobalVaribles globalVaribles2 =new GlobalVaribles();
    expect(globalVaribles1, equals(globalVaribles2));
  });

  test('globalSingle should has access_token property', (){
    GlobalVaribles globalVaribles = new GlobalVaribles();
    expect(globalVaribles.accessToken, globalVaribles.accessToken != null);
  });
}