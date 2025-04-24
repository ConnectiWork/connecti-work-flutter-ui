import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';

class GoogleMapsWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onLocationSelected;

  const GoogleMapsWidget({super.key, required this.onLocationSelected});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _mapLoaded = false;

  // Initial camera position (centered on Morocco)
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(31.7917, -7.0926), // Centered on Morocco
    zoom: 5.5, // Zoom out to show more of the country
  );

  // City locations - only Tangier, Casablanca, and Rabat
  final List<Map<String, dynamic>> _cities = [
    {
      'name': 'Casablanca',
      'jobCount': 124,
      'position': const LatLng(33.5731, -7.5898),
      'color': AppColors.primary,
    },
    {
      'name': 'Rabat',
      'jobCount': 87,
      'position': const LatLng(34.0209, -6.8416),
      'color': AppColors.accent,
    },
    {
      'name': 'Tangier',
      'jobCount': 42,
      'position': const LatLng(35.7595, -5.8340),
      'color': AppColors.moroccanGreen,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _mapLoaded = true;
    });

    debugPrint('Google Map created successfully');

    // Add markers after map is created
    _addMarkers();
  }

  void _addMarkers() {
    if (!mounted) return;

    setState(() {
      _markers.clear();
      for (final city in _cities) {
        final marker = Marker(
          markerId: MarkerId(city['name']),
          position: city['position'],
          infoWindow: InfoWindow(
            title: city['name'],
            snippet: '${city['jobCount']} jobs available',
          ),
          onTap: () {
            _onCitySelected(city);
          },
        );
        _markers.add(marker);
      }
    });
  }

  void _onCitySelected(Map<String, dynamic> city) {
    // Animate camera to center on the selected city
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: city['position'], zoom: 12.0),
      ),
    );

    // Call the callback with city data
    widget.onLocationSelected({
      'name': city['name'],
      'jobCount': city['jobCount'],
      'position': city['position'],
    });

    // Show a simple snackbar with city info
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected ${city['name']} - ${city['jobCount']} jobs available',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: city['color'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color in case map doesn't load
        Container(color: Colors.grey[200]),

        // Google Map
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _onMapCreated,
          markers: _markers,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
        ),

        // Refresh button
        Positioned(
          top: 10,
          right: 10,
          child: FloatingActionButton.small(
            backgroundColor: AppColors.primary,
            onPressed: () {
              if (_mapController != null) {
                debugPrint('Refreshing map...');
                _mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(_initialCameraPosition),
                );
                _addMarkers();
              }
            },
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
        ),

        // Help text if map is not loaded
        if (!_mapLoaded)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(220),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  'Map is loading... Please wait',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
