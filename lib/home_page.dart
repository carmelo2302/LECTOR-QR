import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreadreapp/src/bloc/scans_bloc.dart';
import 'package:qrreadreapp/src/models/scan_model.dart';
import 'package:qrreadreapp/src/pages/direcciones_page.dart';
import 'package:qrreadreapp/src/pages/mapas_page.dart';
import 'package:qrreadreapp/src/utils/utils.dart' as utils;
//import 'package:qrcode_reader/qrcode_reader.dart';
//import 'package:qrreadreapp/src/provider/db_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = ScansBloc();
  int pagina=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scaner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTODO,
          ),
        ],
      ),
      body: Center(
        child: _callPage(pagina),
      ),
      bottomNavigationBar: _bottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed:() => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
  _scanQR(BuildContext context ) async {
    //String geo='geo:40.724233047051705,-74.00731459101564';
    String futureString ;
    setState(() {});
    try{
      futureString= await new QRCodeReader().scan();
    }catch(e){
      futureString = e.toString();
    }
    if(futureString!= null){
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScans(scan);

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750) , (){
          utils.abrirScan(context ,scan);
        });
      }else{
        utils.abrirScan(context ,scan);
      }

    }
  }

  Widget _bottomNavigatorBar() {
    return BottomNavigationBar(
      currentIndex: pagina,
      onTap: (index){
        setState(() {
          pagina=index;
        });

      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ]
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default: 
        return MapasPage();
    }
  }
}