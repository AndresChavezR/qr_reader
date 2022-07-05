import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType tipoMapa = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17.4746, tilt: 50);
    Set<Marker> markers = Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId('geo-loaction'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: scan.getLatLng(), zoom: 19.0)));
              },
              icon: Icon(Icons.location_on_sharp))
        ],
      ),
      body: GoogleMap(
        mapType: tipoMapa,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (tipoMapa == MapType.normal) {
              tipoMapa = MapType.satellite;
            } else {
              tipoMapa = MapType.normal;
            }
          });
        },
      ),
    );
  }
}
