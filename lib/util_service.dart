import 'package:STTS/Constants/constants.dart';
import 'package:sqflite/sqflite.dart';

class UtilService {
  ///Open the local sqlite database
  static Future<Database> openDB() async {
    return await openDatabase('STTS_UGANDA_${Constants.appVersion}',
        version: Constants.appVersion);
  }
}
