import 'package:STTS/Constants/table_names.dart';
import 'package:STTS/models/add_sample_analysis.dart';
import 'package:STTS/models/add_seed_label.dart';
import 'package:STTS/models/add_stock_exam.dart';
import 'package:STTS/models/add_stock_form.dart';
import 'package:STTS/models/lab_test_number.dart';
import 'package:STTS/models/seed_lab.dart';
import 'package:STTS/models/seed_label.dart';
import 'package:STTS/models/seed_label_package.dart';
import 'package:STTS/models/seed_stock.dart';
import 'package:STTS/models/stock_examination.dart';
import 'package:STTS/models/update_lab_results.dart';
import 'package:STTS/stts_printer.dart';
import 'package:STTS/util_service.dart';
import 'package:sqflite/sqflite.dart';
import '../Constants/stts_uganda_exports.dart';
import '../models/accepted_model.dart';

class SeedRepository {
  static Future<void> submitSeedExam(AddStockExam addStockExam) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('form-stock-examination-requests', data: addStockExam);
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitSeedLabel(AddSeedLabel addSeedLabel) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('seed-labels', data: addSeedLabel);
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<AcceptedModel>> getAcceptedPermits(int userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('get-accepted-import-permits/$userId');

      List<AcceptedModel> acceptedPermits = [];
      for (Map<String, dynamic> acceptedPermit in response.data) {
        acceptedPermits.add(AcceptedModel.fromJson(acceptedPermit));
      }
      return acceptedPermits;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<AcceptedModel>> getAcceptedPlantingReturns(
      int userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response =
          await dio.request('get-accepted-planting-returns/$userId');

      List<AcceptedModel> acceptedPlantingReturns = [];
      for (Map<String, dynamic> acceptedPlantingReturn in response.data) {
        acceptedPlantingReturns
            .add(AcceptedModel.fromJson(acceptedPlantingReturn));
      }
      return acceptedPlantingReturns;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<AcceptedModel>> getAcceptedQDS(int userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response =
          await dio.request('get-accepted-qds-declarations/$userId');

      List<AcceptedModel> acceptedQDS = [];
      for (Map<String, dynamic> acceptedQD in response.data) {
        acceptedQDS.add(AcceptedModel.fromJson(acceptedQD));
      }
      return acceptedQDS;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SeedLabel>> getSeedLabels(int userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('seed-labels/$userId');

      List<SeedLabel> seedLabels = [];
      for (Map<String, dynamic> seedLabel in response.data) {
        seedLabels.add(SeedLabel.fromJson(seedLabel));
      }
      return seedLabels;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SeedLabelPackage>> getSeedLabelPackages() async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('get-seed-label-packages');

      List<SeedLabelPackage> seedLabelPackages = [];
      for (Map<String, dynamic> seedLabelPackage in response.data) {
        seedLabelPackages.add(SeedLabelPackage.fromJson(seedLabelPackage));
      }
      return seedLabelPackages;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<LabTestNumber>> getLabTestNumbers(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('get-lab-test-number/$userId');

      List<LabTestNumber> labTestNumbers = [];
      for (Map<String, dynamic> labTestNumber in response.data) {
        labTestNumbers.add(LabTestNumber.fromJson(labTestNumber));
      }
      return labTestNumbers;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<AcceptedModel>> getAcceptedCropVarieties(
      int permitId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('get-crop-varieties/$permitId');

      List<AcceptedModel> acceptedVarieties = [];
      for (Map<String, dynamic> acceptedVariety in response.data) {
        acceptedVarieties.add(AcceptedModel.fromJson(acceptedVariety));
      }

      return acceptedVarieties;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<StockExamination>> getStockExaminations(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = locator<UserController>().user?.roles[0].name == "Basic User"
          ? 'form-stock-examination-requests'
          : 'assigned-form-stock-examination-requests';
      final response = await dio.request('$url/$userId');

      List<StockExamination> stockExaminations = [];
      for (Map<String, dynamic> stockExamination in response.data) {
        stockExaminations.add(
          StockExamination.fromJson(stockExamination),
        );
      }
      return stockExaminations;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SeedLab>> getSeedLabs(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final Response response;
      if (locator<UserController>().user?.roles[0].name == "Lab technician") {
        var url = 'forms-sent-to-lab';
        response = await dio.request(url);
      } else {
        var url = locator<UserController>().user?.roles[0].name == "Basic User"
            ? 'seed-labs'
            : 'assigned-seed-labs';
        response = await dio.request('$url/$userId');
      }

      List<SeedLab> seedLabs = [];
      for (Map<String, dynamic> seedLab in response.data) {
        seedLabs.add(
          SeedLab.fromJson(seedLab),
        );
      }
      return seedLabs;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SeedStock>> getSeedStocks(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('stock-records/$userId');

      List<SeedStock> seedStocks = [];
      for (Map<String, dynamic> seedStock in response.data) {
        seedStocks.add(
          SeedStock.fromJson(seedStock),
        );
      }
      return seedStocks;
    } catch (__) {
      rethrow;
    }
  }

  //* Save the stock exam to local database
  static Future<void> saveStockExamination(AddStockExam addStockExam) async {
    // open the database
    await UtilService.openDB().then((localDB) async {
      // if the database is not open, show error toast and return
      if (!localDB.isOpen) {
        printer("Failed to init local store.");
        return;
      }

      // init the table
      await createStockExamTableIfNotExists(localDB).then((_) async {
        printer("Stock exam table ${localDB.toString()} created successfully");
        // insert the user to the table
        try {
          await localDB
              .insert(
                stockExamTable,
                addStockExam.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              )
              .then((_) => printer("Stock Exams saved successfully 4"));
        } catch (e) {
          printer("Failed to save stock exam because ${e.toString()}");
        }
      });
    });
  }

  /// create the user table if it doesn't exist
  static Future<void> createStockExamTableIfNotExists(Database localDB) async {
    String sql = " CREATE TABLE IF NOT EXISTS "
        "$stockExamTable ("
        "id INTEGER PRIMARY KEY,"
        "administrator_id TEXT,"
        "import_export_permit_id TEXT,"
        "lot_number TEXT,"
        ")";

    try {
      // execute the sql
      await localDB.execute(sql).then(
          (_) => printer("Stock table created successfully", isSuccess: true));
    } catch (e) {
      printer('Failed to create table because ${e.toString()}');
    }
  }

  static Future<void> submitStockExamForm(AddStockForm addStockForm, id) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var url = 'form-stock-examination-requests/$id';
      await dio.put(
        url,
        data: addStockForm,
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitSeedSampleAnalysis(
      AddSampleAnalysis addSampleAnalysis, id) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var url = 'seed-labs/$id';
      await dio.put(
        url,
        data: addSampleAnalysis,
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitLabTest(
      UpdateLabResults updateLabResults, id) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var url = 'lab-results/$id';
      await dio.put(
        url,
        data: updateLabResults,
      );
    } catch (__) {
      rethrow;
    }
  }
}
