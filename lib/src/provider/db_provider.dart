import 'package:qrreadreapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if (_database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documenntsDirectiry = await  getApplicationDocumentsDirectory();

    final path = join(documenntsDirectiry.path , 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );

  }

  //CREAR REGISTRO 

  nuevoScans(ScanModel nuevoScans) async {
    final db= await database;
    final res = await db.insert('Scans', nuevoScans.toJson());
    return res;

  }

  // SELECT - OBTENER INFORMACION 
  Future<ScanModel> getScanId(int id ) async{
    final db =await database;
    final res = await db.query('scans', where: 'id = ?' , whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first ) : null;
  }

  Future<List<ScanModel>> getTodosScans() async{
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
                                        ? res.map( (c)=>ScanModel.fromJson(c)).toList()
                                        : [];
    return list;

  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db =await database;
    final res= await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> list = res.isNotEmpty
                                      ? res.map((c) => ScanModel.fromJson(c)).toList()
                                      : [];
    return list;
  }

  //ACTUALIZAR REGISTROS
  Future<int> uodateScan(ScanModel nuevoScan) async{
    final db = await database;
    final res= await db.update('Scans', nuevoScan.toJson(),where: 'id= ?',whereArgs: [nuevoScan.id]);
    return res;
  }

  //borrar registro 
  Future<int>  deleteScan(int id) async{
    final db= await database;
    final res = await db.delete('Scans' ,where: 'id = ?', whereArgs: [id]);
    return res;
  }
    Future<int>  deleteAll() async{
    final db= await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }
}