// ignore_for_file: uri_does_not_exist, undefined_import, undefined_identifier
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  dynamic myPosition;

  @override
  void initState() {
    super.initState();
    getPosition().then((pos) {
      setState(() {
        myPosition = pos;
      });
    });
  }

  Future<dynamic> getPosition() async {
    await Geolocator.requestPermission();
    // Delay added to visualize loading per praktikum 6 step 8
    await Future.delayed(const Duration(seconds: 3));
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location - Rakai')),
      body: Center(
        child: myPosition == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Fetching position...'),
                ],
              )
            : Text(
                'Latitude: ${myPosition!.latitude}, Longitude: ${myPosition!.longitude}',
              ),
      ),
    );
  }
}


