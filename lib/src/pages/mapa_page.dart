import 'package:flutter/material.dart';
import 'package:qrreadreapp/src/models/scan_model.dart'; 

import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map= MapController();
  String tipomapa='streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('CORDENADAS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              map.move(scan.getLanLng(), 15);
            }
          )
        ],
      ),
      body: _crearFlutterMapa(scan),
      floatingActionButton: _cambiarmapa(context),
    );
  }

  Widget _crearFlutterMapa(ScanModel scan) {
    return  FlutterMap(
      mapController: map,
    options: MapOptions(
      center: scan.getLanLng(),
      zoom: 13.0,
    ),
    layers: [
      _crearMapa(),
      _crarMarcadores(scan),
      ],
    );
  }

  TileLayerOptions _crearMapa() {
    return TileLayerOptions(
      urlTemplate: "https://api.mapbox.com/v4/"
          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiY2FybWVsb3JzIiwiYSI6ImNrOXp1eDhxMDBlcnYzZncxNndseXM1ajMifQ.aelzbudFnvyl4wl_IZwhZQ',
        'id': 'mapbox.$tipomapa',
      },
      );
  }

  _crarMarcadores(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLanLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 75.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ]
    );
  }

  Widget _cambiarmapa(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(tipomapa =='streets'){
          tipomapa= 'dark';
        }else if (tipomapa== 'dark'){
          tipomapa='light';
        }else if (tipomapa== 'light'){
          tipomapa='outdoors';
        }else if (tipomapa== 'outdoors'){
          tipomapa='satellite';
        }else {
          tipomapa='streets';
        }
        setState(() {
          
        });
      },
    );
  }
}