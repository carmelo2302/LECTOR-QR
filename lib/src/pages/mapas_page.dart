import 'package:flutter/material.dart';
import 'package:qrreadreapp/src/bloc/scans_bloc.dart';
import 'package:qrreadreapp/src/models/scan_model.dart';
import 'package:qrreadreapp/src/utils/utils.dart';
//import 'package:qrreadreapp/src/provider/db_provider.dart';

class MapasPage extends StatelessWidget {
  final scanBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {

    scanBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scansStreamgeo,
      builder: (BuildContext context , AsyncSnapshot<List<ScanModel>> snapshot){
        
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        final scans= snapshot.data;

        if(scans.length==0){
          return Center(
            child: Text('no hay informacion',style: TextStyle(color: Colors.red,fontSize: 25.0)),
          );
        }
        

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context , i)=> Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.redAccent,
              child: Center(child: Text('Eliminado ',style: TextStyle(color: Colors.white,fontSize: 25.0),),),),
            onDismissed: ( direction ) => scanBloc.borrarScan(scans[i].id),
            child: ListTile(
              onTap: () => abrirScan(context, scans[i]),
              leading: Icon(Icons.map , color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id} '),
              trailing: Icon(Icons.keyboard_arrow_right , color: Theme.of(context).primaryColor,),
            ),
          ),
        );
      },
    );
  }
}