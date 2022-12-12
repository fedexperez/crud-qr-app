import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:crudqr/models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  //Private Constructor
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Path de almacenamiento de la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    });
  }

  //Async, espera que haga el procedimiento y luego obtengo la respuesta
  Future<int> newRawScan(ScanModel newScan) async {
    final id = newScan.id;
    final scanType = newScan.tipo;
    final scanValue = newScan.valor;

    //Verificar base de datos
    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO Scans(id, tipo, valor)
      VALUES($id, '$scanType', '$scanValue')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toMap());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    final finalRes = res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
    return finalRes;
  }

  Future<ScanModel?> getScanByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    final finalRes = res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
    return finalRes;
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    final finalRes =
        res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : null;
    return finalRes;
  }

  Future<List<ScanModel>?> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    final finalRes =
        res.isNotEmpty ? res.map((s) => ScanModel.fromMap(s)).toList() : null;
    return finalRes;
  }

  Future<int> updateScan(ScanModel scanToUpdate) async {
    final db = await database;
    final res = await db.update('Scans', scanToUpdate.toMap(),
        where: 'id = ?', whereArgs: [scanToUpdate.id]);
    return res;
  }

  Future<int> deleteScan(id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
