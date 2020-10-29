import 'dart:async';

import 'package:qrreadreapp/src/bloc/validacion.dart';
import 'package:qrreadreapp/src/models/scan_model.dart';
import 'package:qrreadreapp/src/provider/db_provider.dart';

class ScansBloc with Validador{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }
  ScansBloc._internal(){

    //obtener scans de la base de datos 
  }

  final _scansController= StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamgeo => _scansController.stream.transform(validadorGeo);
  Stream<List<ScanModel>> get scansStreamhttp => _scansController.stream.transform(validadorhttp);
  dispose(){
    _scansController?.close();
  }

  obtenerScans()async{
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }
  agregarScans(ScanModel scan) async {
    await DBProvider.db.nuevoScans(scan);
    obtenerScans();
  }
  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }
  borrarScanTODO() async{
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}