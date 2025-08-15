import 'package:STTS/models/trace.dart';
import 'package:flutter/material.dart';
import '../repositories/seed_scanning_repository.dart';

class SeedScanningController with ChangeNotifier {
  dynamic exception;
  bool isLoading = false;
  List<Trace> traces = [];
  Trace? trace;
  Future setTrace(String lotNumber) async {
    try {
      List<dynamic> results = await Future.wait([
        SeedScanningRepository.traceSeed(lotNumber),
      ], eagerError: true);
      trace = results[0];
    } catch (e) {
      rethrow;
    }
  }

  void traceSeed(String lotNumber) async {
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
    }
    try {
      await Future.wait([
        setTrace(lotNumber),
      ], eagerError: true);
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchTracks(String motherLot) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      traces = [];
      List<Trace> results = await SeedScanningRepository.trackSeed(motherLot);

      traces.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }
}
