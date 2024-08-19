import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng _pickedLocation;

  @override
  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(37.7749, -122.4194); // Default to San Francisco
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Location'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _pickedLocation,
                  zoom: 16,
                ),
                onTap: _selectLocation,
                markers: {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation,
                  ),
                },
              ),
            ),
            if (_pickedLocation != null)
              Text(
                'Latitude: ${_pickedLocation.latitude}, Longitude: ${_pickedLocation.longitude}',
              ),
          ],
        ),
      ),
    );
  }
}
