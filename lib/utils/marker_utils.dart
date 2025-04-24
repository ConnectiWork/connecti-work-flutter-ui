import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_colors.dart';

class MarkerUtils {
  // Cache for custom marker bitmaps
  static final Map<String, BitmapDescriptor> _markerCache = {};
  
  // Get a custom marker with a modern design
  static Future<BitmapDescriptor> getCustomMarker(String cityName) async {
    // Check if marker is already in cache
    if (_markerCache.containsKey(cityName)) {
      return _markerCache[cityName]!;
    }
    
    // Create a custom marker based on city name
    final ByteData data = await rootBundle.load('assets/images/map_marker.png');
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 120,
      targetHeight: 120,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    
    // Create a bitmap descriptor from the image
    final bitmap = await _createBitmapDescriptor(fi.image);
    
    // Cache the marker
    _markerCache[cityName] = bitmap;
    return bitmap;
  }
  
  // Create a bitmap descriptor from an image
  static Future<BitmapDescriptor> _createBitmapDescriptor(ui.Image image) async {
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }
  
  // Fallback to colored default markers if custom markers fail to load
  static BitmapDescriptor getDefaultMarker(String cityName) {
    switch (cityName) {
      case 'Casablanca':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
      case 'Rabat':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
      case 'Tangier':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    }
  }
  
  // Get a custom job marker
  static BitmapDescriptor getJobMarker(String jobType) {
    // For now, all job markers are purple
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  }
}
