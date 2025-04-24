import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:feather_icons/feather_icons.dart';
import '../theme/app_colors.dart';
import 'custom_map_marker.dart';

class GoogleMapsWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onLocationSelected;

  const GoogleMapsWidget({super.key, required this.onLocationSelected});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Marker> _jobMarkers = {};
  bool _mapLoaded = false;
  String? _selectedCity;

  // Initial camera position (centered on Morocco and zoomed to show all three cities)
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(34.0209, -6.8416), // Centered on Rabat (middle city)
    zoom: 7.0, // Zoomed to show all three cities
  );

  // City locations - only Tangier, Casablanca, and Rabat
  final List<Map<String, dynamic>> _cities = [
    {
      'name': 'Casablanca',
      'jobCount': 124,
      'position': const LatLng(33.5731, -7.5898),
      'color': AppColors.primary,
      'jobs': [
        {
          'title': 'Security Staff',
          'company': 'World Cup Security',
          'position': const LatLng(33.5831, -7.5998),
        },
        {
          'title': 'Event Coordinator',
          'company': 'Casablanca Stadium',
          'position': const LatLng(33.5631, -7.5798),
        },
        {
          'title': 'Food Service',
          'company': 'Fan Zone Catering',
          'position': const LatLng(33.5531, -7.5698),
        },
      ],
    },
    {
      'name': 'Rabat',
      'jobCount': 87,
      'position': const LatLng(34.0209, -6.8416),
      'color': AppColors.accent,
      'jobs': [
        {
          'title': 'Hospitality Assistant',
          'company': 'Royal Mansour Hotel',
          'position': const LatLng(34.0309, -6.8516),
        },
        {
          'title': 'Translator',
          'company': 'World Cup Media Center',
          'position': const LatLng(34.0109, -6.8316),
        },
      ],
    },
    {
      'name': 'Tangier',
      'jobCount': 42,
      'position': const LatLng(35.7595, -5.8340),
      'color': AppColors.moroccanGreen,
      'jobs': [
        {
          'title': 'Event Staff',
          'company': 'Tangier Stadium',
          'position': const LatLng(35.7695, -5.8440),
        },
        {
          'title': 'Transportation Guide',
          'company': 'World Cup Transit',
          'position': const LatLng(35.7495, -5.8240),
        },
      ],
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
          // Use map-pin icon from Feather Icons (via BitmapDescriptor)
          // All pins should be purple as requested
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet, // Purple for all pins
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

    // Set selected city
    setState(() {
      _selectedCity = city['name'];
    });

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

    // Show job markers for the selected city
    _showJobMarkers(city);

    // Show a simple snackbar with city info
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selected ${city['name']} - ${city['jobCount']} jobs available',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.primary, // All snackbars should be purple
        ),
      );
    }
  }

  // Show job markers for the selected city
  void _showJobMarkers(Map<String, dynamic> city) {
    if (!mounted) return;

    // Create job markers
    final Set<Marker> newJobMarkers = {};
    final List<dynamic> jobs = city['jobs'];

    for (int i = 0; i < jobs.length; i++) {
      final job = jobs[i];
      final marker = Marker(
        markerId: MarkerId('job_${city['name']}_$i'),
        position: job['position'],
        // Use target icon from Feather Icons (via BitmapDescriptor)
        // All job markers should be purple as requested
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet, // Purple for all job markers
        ),
        infoWindow: InfoWindow(title: job['title'], snippet: job['company']),
      );

      newJobMarkers.add(marker);
    }

    // Update job markers
    setState(() {
      _jobMarkers.clear();
      _jobMarkers.addAll(newJobMarkers);

      // Add job markers to the map
      _markers.addAll(_jobMarkers);
    });

    debugPrint('Added ${_jobMarkers.length} job markers for ${city['name']}');
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

        // Refresh button at bottom right with Feather Icon
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: AppColors.primary, // Changed to purple
            elevation: 3,
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition),
              );
              _addMarkers();
              debugPrint('Map refreshed');
            },
            child: const Icon(
              FeatherIcons.refreshCw,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),

        // Loading indicator
        if (!_mapLoaded)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary, // Purple
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
                        color: AppColors.dark.withAlpha(
                          20,
                        ), // Dark with opacity
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Loading map...',
                    style: TextStyle(
                      color: AppColors.primary, // Purple
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
