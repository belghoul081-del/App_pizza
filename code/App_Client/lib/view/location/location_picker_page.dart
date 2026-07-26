import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_pizza_client/constant/app_color.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final MapController _mapController = MapController();
  final LatLng _shopLocation = const LatLng(35.7220129, 0.5408058);
  LatLng _currentCenter = const LatLng(35.7339, 0.5589); //غليزان كموقع افتراضي
  bool _isLocating = true;

  @override
  void initState() {
    super.initState();
    _goToMyLocation();
  }

  Future<void> _goToMyLocation() async {
    if (!mounted) return;
    setState(() => _isLocating = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _isLocating = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Please activate the GPS (location service) on your phone",
              ),
            ),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => _isLocating = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Access to the location has not been granted"),
            ),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      if (!mounted) return;

      setState(() {
        _currentCenter = LatLng(position.latitude, position.longitude);
        _isLocating = false;
      });

      // تحريك الخريطة مباشرة
      _mapController.move(_currentCenter, 16);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLocating = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred while fetching the location: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locate your location"),
        backgroundColor: ColorApp_Background.appbarecolor,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 14,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  _currentCenter = position.center;
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.infinitypizza.app_pizza_client',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _shopLocation,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: const Column(
                      children: [
                        Icon(
                          Icons.store,
                          size: 40,
                          color: Color.fromARGB(255, 255, 123, 0),
                        ),
                        Text(
                          "restaurant",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 123, 0),

                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            backgroundColor: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(Icons.location_pin, size: 48, color: Colors.red),
            ),
          ),

          if (_isLocating)
            const Positioned(
              top: 16,
              right: 16,
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 100,
            right: 24,
            child: FloatingActionButton(
              heroTag: "my_location_btn",
              backgroundColor: Colors.white,
              onPressed: _goToMyLocation,
              child: const Icon(Icons.my_location, color: Colors.blueAccent),
            ),
          ),

          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp_Botton.bottonOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(_currentCenter);
              },
              child: const Text(
                "Location confirmation",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
