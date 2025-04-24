import 'dart:async';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/job_location.dart';
import '../services/auth_service.dart';
import '../services/map_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/simple_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  String _selectedLocationId = '';
  bool _isMapLoaded = false;
  bool _useSimpleMap = false; // Set to true if Google Maps fails to load

  @override
  void initState() {
    super.initState();
    _initMarkers();
  }

  Future<void> _initMarkers() async {
    try {
      final markers = await MapService.createMarkers(
        jobLocations,
        _onMarkerTap,
      );

      setState(() {
        _markers = markers;
        _isMapLoaded = true;
      });
    } catch (e) {
      print('Error initializing Google Maps: $e');
      setState(() {
        _useSimpleMap = true;
        _isMapLoaded = true;
      });
    }
  }

  void _onMarkerTap(String locationId) {
    setState(() {
      _selectedLocationId = locationId;
    });

    // Find the location
    final location = jobLocations.firstWhere(
      (loc) => loc.id == locationId,
      orElse: () => jobLocations.first,
    );

    // Animate to the location
    _controller.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: location.position, zoom: 10),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userName = authService.name?.split(' ').first ?? 'User';
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        onPressed: () {
          if (!_useSimpleMap) {
            _controller.future.then((controller) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  MapService.initialCameraPosition,
                ),
              );
            });
          }
          setState(() {
            _selectedLocationId = '';
          });
        },
        child: const Icon(FeatherIcons.maximize, color: AppColors.primary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Stack(
        children: [
          // Map View (Google Maps or Simple Map)
          _useSimpleMap
              ? SimpleMap(
                locations: jobLocations,
                selectedLocationId: _selectedLocationId,
                onLocationSelected: _onMarkerTap,
              )
              : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: MapService.initialCameraPosition,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),

          // Loading indicator
          if (!_isMapLoaded)
            Container(
              color: Colors.white.withAlpha(178), // 70% opacity
              child: const Center(child: CircularProgressIndicator()),
            ),

          // These are duplicate pins for the background - we'll remove them
          // since we already have pins in the map placeholder

          // Top Bar with User Stats
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: CustomCard(
              elevation: 4,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      FeatherIcons.user,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, $userName',
                          style: AppTextStyles.heading4,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: AppColors.moroccanYellow,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              FeatherIcons.briefcase,
                              color: AppColors.primary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text('12 Jobs', style: AppTextStyles.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      FeatherIcons.bell,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter Bar
          Positioned(
            top: 140,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(
                    FeatherIcons.search,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search for jobs in Morocco',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                  Container(height: 36, width: 1, color: AppColors.divider),
                  const SizedBox(width: 8),
                  // Map toggle button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _useSimpleMap = !_useSimpleMap;
                      });
                    },
                    child: Icon(
                      _useSimpleMap ? FeatherIcons.map : FeatherIcons.mapPin,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    FeatherIcons.sliders,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),

          // Job Clusters
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Job Opportunities Nearby', style: AppTextStyles.heading4),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jobLocations.length,
                    itemBuilder: (context, index) {
                      final location = jobLocations[index];
                      final isSelected = location.id == _selectedLocationId;

                      return Container(
                        width: 160,
                        margin: EdgeInsets.only(
                          right: 12,
                          bottom: isSelected ? 0 : 4,
                          top: isSelected ? 4 : 0,
                        ),
                        child: _buildJobCluster(
                          location.city,
                          location.jobCount,
                          location.color,
                          isSelected: isSelected,
                          onTap: () => _onMarkerTap(location.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCluster(
    String location,
    String jobCount,
    Color color, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      elevation: isSelected ? 4 : 2,
      borderRadius: 12,
      padding: const EdgeInsets.all(12),
      isHighlighted: isSelected,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(FeatherIcons.mapPin, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            jobCount,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'View Jobs',
            onPressed: () {},
            type: isSelected ? ButtonType.primary : ButtonType.secondary,
            height: 36,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
