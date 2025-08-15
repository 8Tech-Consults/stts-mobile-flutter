import 'package:STTS/Constants/stts_uganda_exports.dart';

class PreferenceUtils {
  User? user;

  void getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user = User.fromJson(
      jsonDecode(sharedPreferences.getString('user') ?? ''),
    );
  }
}
