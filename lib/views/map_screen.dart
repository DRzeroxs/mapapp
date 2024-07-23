import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mapapp/models/location_model.dart';
import 'package:mapapp/utils/geocoding_service.dart';

class MapScreen extends StatefulWidget{
  final LocationModel location;

  MapScreen({required this.location});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>{
  late LatLng _latLng;
  String _address = '';

  @override
  void initState(){
    super.initState();
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);
    _getAddress();
  }

  void _getAddress() async {
    try {

      String address = await GeocodingService.getAddressFromCoordinates(
        widget.location.latitude,
        widget.location.longitude
      );

      setState(() {
        _address = address;
      });

    }catch(e){
      Fluttertoast.showToast(msg: 'Failed to get address');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _latLng,
          zoom: 13.0,
          onTap: (tapPosition, point){
            Fluttertoast.showToast(
              msg: '${widget.location.nombre} ${widget.location.apellido}\n$_address',
              toastLength: Toast.LENGTH_LONG,
            );
          }
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _latLng,
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}