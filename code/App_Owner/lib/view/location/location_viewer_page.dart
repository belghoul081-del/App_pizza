import 'package:app_owner/constant/app_color.dart';
import 'package:app_owner/models/order/location_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationViewerPage extends StatelessWidget {
  final Location_Model location;
  const LocationViewerPage({super.key, required this.location});
  static const double shopLat = 35.7220129;
  static const double shopLng = 0.5408058;
  Future<void> _openRouteInGoogleMaps({
    required double customerLat,
    required double customerLng,
  }) async {
    final String urlString =
        'https://www.google.com/maps/dir/?api=1&origin=$shopLat,$shopLng&destination=$customerLat,$customerLng';

    final Uri googleMapsUri = Uri.parse(urlString);

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not open Google Maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng point = LatLng(location.lat, location.lng);
    final LatLng shopPoint = const LatLng(shopLat, shopLng);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Location"),
        backgroundColor: ColorApp_Background.appbarecolor,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: point, initialZoom: 16),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.infinitypizza.app_owner',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: 48,
                    height: 48,
                    child: const Icon(
                      Icons.location_pin,
                      size: 48,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: shopPoint,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: const Column(
                      children: [
                        Icon(
                          Icons.store_mall_directory_outlined,
                          size: 40,
                          color: Color.fromARGB(255, 255, 149, 0),
                        ),
                        Text(
                          "shop",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 149, 0),
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

          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp_Botton.bottonOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () => _openRouteInGoogleMaps(
                customerLat: location.lat,
                customerLng: location.lng,
              ),
              icon: const Icon(Icons.directions, color: Colors.white),
              label: const Text(
                "Open navigation in Maps app",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
