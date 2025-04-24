import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/job_location.dart';
import '../theme/app_colors.dart';

class MapService {
  // Default camera position (Morocco)
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(31.7917, -7.0926), // Center of Morocco
    zoom: 5.5,
  );

  // Create markers from job locations
  static Future<Set<Marker>> createMarkers(
    List<JobLocation> locations,
    Function(String) onMarkerTap,
  ) async {
    Set<Marker> markers = {};

    for (var location in locations) {
      final marker = Marker(
        markerId: MarkerId(location.id),
        position: location.position,
        infoWindow: InfoWindow(
          title: location.city,
          snippet: location.jobCount,
        ),
        onTap: () => onMarkerTap(location.id),
        icon: BitmapDescriptor.defaultMarkerWithHue(_getMarkerHue(location.color)),
      );

      markers.add(marker);
    }

    return markers;
  }

  // Create custom markers with job count
  static Future<Set<Marker>> createCustomMarkers(
    List<JobLocation> locations,
    BuildContext context,
    Function(String) onMarkerTap,
  ) async {
    Set<Marker> markers = {};

    for (var location in locations) {
      // Create a custom marker icon
      final BitmapDescriptor markerIcon = await _createCustomMarkerBitmap(
        location.city,
        location.availableJobs.toString(),
        location.color,
        context,
      );

      final marker = Marker(
        markerId: MarkerId(location.id),
        position: location.position,
        infoWindow: InfoWindow(
          title: location.city,
          snippet: location.jobCount,
        ),
        onTap: () => onMarkerTap(location.id),
        icon: markerIcon,
      );

      markers.add(marker);
    }

    return markers;
  }

  // Helper method to convert Color to BitmapDescriptor hue
  static double _getMarkerHue(Color color) {
    // Default to red if color doesn't match
    if (color == AppColors.primary) return BitmapDescriptor.hueBlue;
    if (color == AppColors.moroccanRed) return BitmapDescriptor.hueRed;
    if (color == AppColors.moroccanBlue) return BitmapDescriptor.hueAzure;
    if (color == AppColors.moroccanGreen) return BitmapDescriptor.hueGreen;
    if (color == AppColors.moroccanYellow) return BitmapDescriptor.hueYellow;
    return BitmapDescriptor.hueRed;
  }

  // Create a custom marker bitmap
  static Future<BitmapDescriptor> _createCustomMarkerBitmap(
    String title,
    String jobCount,
    Color color,
    BuildContext context,
  ) async {
    // For now, use default markers with hue
    // In a real app, you would create custom marker widgets and convert them to bitmaps
    return BitmapDescriptor.defaultMarkerWithHue(_getMarkerHue(color));
  }

  // Get map style (dark/light)
  static String getMapStyle(bool isDarkMode) {
    // For simplicity, we're using default style
    // In a real app, you would load JSON style files
    return '';
  }
}
