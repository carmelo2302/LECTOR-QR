import 'package:flutter/material.dart';
import 'package:qrreadreapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context ,ScanModel scan) async{

  if(scan.tipo =='http'){

    if(await canLaunch(scan.valor)){
      await launch(scan.valor);
    }else{
      throw 'La direcion ${scan.valor} no se encuentra';
    }
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
}