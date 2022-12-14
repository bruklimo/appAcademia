import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class MostraMaps extends StatefulWidget {
  const MostraMaps({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MostraMaps> {
  Uint8List? marketimages;
  List<String> images = [
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
    'assets/gym.png',
  ];

  // created empty list of markers
  final List<Marker> _markers = <Marker>[];

  Location _location = Location();

  // created list of coordinates of various locations
  final List<LatLng> _latLen = <LatLng>[
    LatLng(-22.851260, -47.070230),
    LatLng(-22.851200, -47.066850),
    LatLng(-22.854620, -47.057411),
    LatLng(-22.849770, -47.050590),
    LatLng(-22.855630, -47.051650),
    LatLng(-22.840710, -47.052120),
    LatLng(-22.569440, -47.410150),
    LatLng(-22.546050, -47.420610),
    LatLng(-22.582090, -47.400970),
    LatLng(-22.584560, -47.421590),
    LatLng(-22.555960, -47.407420),
  ];

  late GoogleMapController _controller;

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialize loadData method
    loadData();
  }

  // created method for displaying custom markers according to index
  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markIcons = await getImages(images[i], 100);
      // makers added according to index
      _markers.add(Marker(
        // given marker id
        markerId: MarkerId(i.toString()),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(markIcons),
        // given position
        position: _latLen[i],
        infoWindow: InfoWindow(
          // given title for marker
          title: 'Location: ' + i.toString(),
        ),
      ));
      setState(() {});
    }
  }

  CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-14.235004, -51.925282),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // on below line we have given title of app
        title: Text("Academias Pr??ximas"),
        toolbarHeight: 20,
      ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            // given camera position
            initialCameraPosition: _kGoogle,
            // set markers on google map
            markers: Set<Marker>.of(_markers),
            // on below line we have given map type
            mapType: MapType.normal,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass
            compassEnabled: true,
            // below line displays google map in our app
            onMapCreated: (GoogleMapController _cntlr) {
              _controller = _cntlr;

              _location.onLocationChanged.listen((l) {
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(l.latitude!, l.longitude!), zoom: 15),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
