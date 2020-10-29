

import 'dart:async';

import 'package:qrreadreapp/src/models/scan_model.dart';

class Validador{
  final validadorGeo= StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans ,sink){
      final geoScans= scans.where((s)=> s.tipo =='geo').toList();
      sink.add(geoScans);
    }
  );

  final validadorhttp= StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans ,sink){
      final geoScans= scans.where((s)=> s.tipo =='http').toList();
      sink.add(geoScans);
    }
  );
}