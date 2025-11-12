import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
    await Geolocator.requestPermission();
    // Delay added to visualize loading per praktikum 6 step 8
    await Future.delayed(const Duration(seconds: 3));
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location - Rakai')),
      body: FutureBuilder<Position>(
        future: position,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something terrible happened!'));
            }
            final pos = snapshot.data!;
            return Center(
              child: Text('Latitude: ${pos.latitude}, Longitude: ${pos.longitude}'),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}


