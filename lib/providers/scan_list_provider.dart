import 'package:flutter/material.dart';

import 'package:crudqr/providers/db_provider.dart';

import 'package:crudqr/models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String selectedType = 'http';

  Future<ScanModel> storeNewScan(String scanValue) async {
    //Save on DataBase
    final newScan = ScanModel(valor: scanValue);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    //To show on UI
    if (selectedType == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scansToLoad = await DBProvider.db.getAllScans();
    scans = [...scansToLoad!];
    notifyListeners();
  }

  loadScansByType(String scanType) async {
    final scansToLoad = await DBProvider.db.getScansByTipo(scanType);
    scans = [...?scansToLoad];
    selectedType = scanType;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
