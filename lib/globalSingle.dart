class GlobalVaribles {
  static final GlobalVaribles _singleton = new GlobalVaribles._internal();

  String accessToken = '';
  factory GlobalVaribles() {
    return _singleton;
  }

  GlobalVaribles._internal();
}