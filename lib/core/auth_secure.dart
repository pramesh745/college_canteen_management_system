import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSecure {

  static final _storage = FlutterSecureStorage();

  static const String _loginKey = "loginKey";


  static Future<void>saveLoginKey() async{

    await _storage.write(key: _loginKey, value: "true");
  }



  static Future<bool>isLoggedIn() async{

    bool isLoggedIn = await _storage.read(key: _loginKey) == "true";
    return isLoggedIn;
  }

}