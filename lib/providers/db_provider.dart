import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDataBase();
    return _database!;
  }

  Future<Database> initDataBase() async {
    //Path de donde almacenamos las base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDb.db');
    print('Valor path $path');

    return await openDatabase(path,
        version:
            1, // cada vez que se modifique la base para que tome los nuevos cambios
        onCreate: (Database db, int version) async {
      db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            );
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel scan) async {
    // Verificar que la base de datos exista
    final db = await database;

    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    final res = await db.rawInsert(
        '''INSERT INTO Scans(id, tipo, valor) VALUES ($id, $tipo, $valor)''');
    return res;
  }

  Future<int> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final resp = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : null;
  }

  Future<List<ScanModel>> getScanAll() async {
    final db = await database;
    final resp = await db.query('Scans');

    List<ScanModel> valores = [];
    for (var element in resp) {
      valores.add(ScanModel.fromJson(element));
    }
    return valores;
  }

  Future<List<ScanModel>> getScanByTipo(String tipo) async {
    final db = await database;
    print('Valores por tipo ${tipo}');
    final resp =
        await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    List<ScanModel> valores = [];
    for (var element in resp) {
      valores.add(ScanModel.fromJson(element));
    }
    return valores;
  }

  Future<int> actualizarScan(ScanModel scan) async {
    final db = await database;
    final resp = await db
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return resp;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final resp = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return resp;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final resp = await db.delete('Scans');
    return resp;
  }
}
