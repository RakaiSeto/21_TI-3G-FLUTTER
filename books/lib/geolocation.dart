import 'package:flutter/material.dart';
import 'dart:async';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Position>? position;

  @override
  void initState() {
    super.initState();
    position = getPosition();
  }

  Future<Position> getPosition() async {
    // Simulasi delay untuk mendapatkan posisi GPS
    await Future.delayed(const Duration(seconds: 3));
    // Simulasi koordinat GPS (dalam real app, ini akan menggunakan geolocator)
    return Position(latitude: -7.7956, longitude: 110.3695);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation - Rakai'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: FutureBuilder<Position>(
          future: position,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Something terrible happened!');
              }
              return Text(
                'Latitude: ${snapshot.data?.latitude}\nLongitude: ${snapshot.data?.longitude}',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              );
            }
            return const Text('Waiting...');
          },
        ),
      ),
    );
  }
}

class Position {
  final double latitude;
  final double longitude;

  Position({required this.latitude, required this.longitude});

  @override
  String toString() => 'Position(lat: $latitude, lng: $longitude)';
}

