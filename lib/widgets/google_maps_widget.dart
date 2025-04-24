import 'dart:async';
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
  final Completer<GoogleMapController> _controller = Completer();
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
    debugPrint('Google Map created successfully');

    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }

    // Set a small delay to ensure the map is fully initialized
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        _mapLoaded = true;
      });

      // Add markers after map is created
      _addMarkers();

      // Force a camera update to ensure map is rendered
      controller.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition),
      );
    });

    // Try to get map ID to verify map is working
    try {
      debugPrint('Map controller ID: ${controller.mapId}');
    } catch (e) {
      debugPrint('Error getting map ID: $e');
    }
  }

  void _addMarkers() {
    if (!mounted) return;

    setState(() {
      _markers.clear();
      for (final city in _cities) {
        final marker = Marker(
          markerId: MarkerId(city['name']),
          position: city['position'],
          icon: BitmapDescriptor.defaultMarkerWithHue(
            city['name'] == 'Casablanca'
                ? BitmapDescriptor.hueViolet
                : city['name'] == 'Rabat'
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueRed,
          ),
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

    // Log that markers were added
    debugPrint('Added ${_markers.length} markers to the map');
  }

  Future<void> _onCitySelected(Map<String, dynamic> city) async {
    // Get the controller
    final GoogleMapController controller = await _controller.future;

    // Animate camera to center on the selected city
    controller.animateCamera(
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
    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background color in case map doesn't load
        Container(color: Colors.grey[200]),

        // Google Map with improved configuration
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _onMapCreated,
          markers: _markers,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false, // Hide default zoom controls
          mapType: MapType.normal,
        ),

        // Refresh button at bottom right (more professional)
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: AppColors.primary,
            elevation: 3,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition),
              );
              _addMarkers();
              debugPrint('Map refreshed');
            },
            child: const Icon(Icons.refresh, color: Colors.white, size: 20),
          ),
        ),

        // Loading indicator
        if (!_mapLoaded)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Loading map...',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.future.then((controller) => controller.dispose());
    super.dispose();
  }
}
