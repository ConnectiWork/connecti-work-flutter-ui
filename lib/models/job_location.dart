import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class JobLocation {
  final String id;
  final String city;
  final String jobCount;
  final LatLng position;
  final int availableJobs;
  final Color color;

  JobLocation({
    required this.id,
    required this.city,
    required this.jobCount,
    required this.position,
    required this.availableJobs,
    required this.color,
  });
}

// Sample job locations data
List<JobLocation> jobLocations = [
  JobLocation(
    id: 'casablanca',
    city: 'Casablanca',
    jobCount: '124 jobs',
    position: const LatLng(33.5731, -7.5898),
    availableJobs: 124,
    color: const Color(0xFF1246FF), // AppColors.primary
  ),
  JobLocation(
    id: 'rabat',
    city: 'Rabat',
    jobCount: '87 jobs',
    position: const LatLng(34.0209, -6.8416),
    availableJobs: 87,
    color: const Color(0xFF457B9D), // AppColors.moroccanBlue
  ),
  JobLocation(
    id: 'marrakech',
    city: 'Marrakech',
    jobCount: '56 jobs',
    position: const LatLng(31.6295, -7.9811),
    availableJobs: 56,
    color: const Color(0xFFE63946), // AppColors.moroccanRed
  ),
  JobLocation(
    id: 'tangier',
    city: 'Tangier',
    jobCount: '42 jobs',
    position: const LatLng(35.7595, -5.8340),
    availableJobs: 42,
    color: const Color(0xFFF4A261), // AppColors.moroccanYellow
  ),
  JobLocation(
    id: 'fes',
    city: 'Fes',
    jobCount: '38 jobs',
    position: const LatLng(34.0181, -5.0078),
    availableJobs: 38,
    color: const Color(0xFF2A9D8F), // AppColors.moroccanGreen
  ),
  JobLocation(
    id: 'agadir',
    city: 'Agadir',
    jobCount: '29 jobs',
    position: const LatLng(30.4278, -9.5981),
    availableJobs: 29,
    color: const Color(0xFF5E5CFF), // AppColors.purple
  ),
];
