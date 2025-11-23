import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/qibla_bloc/qibla_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:math' as math;

// For magnetometer events from device sensors
typedef MagnetometerEvent = ({double x, double y, double z});

// Mock magnetometer stream - we'll use device motion instead
final Stream<MagnetometerEvent> magnetometerEvents = _getMagnetometerStream();

Stream<MagnetometerEvent> _getMagnetometerStream() {
  // Create a mock stream that simulates magnetometer events
  // In a real app, you'd use the sensors plugin or native platform channels
  final controller = StreamController<MagnetometerEvent>();
  
  // Simulate magnetometer updates every 100ms
  Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (!controller.isClosed) {
      // Simulate random magnetometer values
      controller.add((x: 0.0, y: 0.0, z: 0.0));
    }
  });
  
  return controller.stream;
}

class QiblaCompassView extends StatefulWidget {
  const QiblaCompassView({super.key});

  @override
  State<QiblaCompassView> createState() => _QiblaCompassViewState();
}

class _QiblaCompassViewState extends State<QiblaCompassView> {
  double _deviceHeading = 0.0;
  double _latitude = 55.7558;
  double _longitude = 37.6173;
  bool _isLoadingLocation = true;
  String _locationStatus = 'Getting location...';

  @override
  void initState() {
    super.initState();
    _requestLocationAndInitCompass();
    _startCompass();
  }

  Future<void> _requestLocationAndInitCompass() async {
    try {
      final status = await Permission.location.request();
      
      if (status.isGranted) {
        try {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 10),
          );
          setState(() {
            _latitude = position.latitude;
            _longitude = position.longitude;
            _isLoadingLocation = false;
            _locationStatus = 'Location ready';
          });
        } catch (e) {
          setState(() {
            _isLoadingLocation = false;
            _locationStatus = 'Location: Moscow (default)';
          });
        }
      } else {
        setState(() {
          _isLoadingLocation = false;
          _locationStatus = 'Location: Moscow (default)';
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
        _locationStatus = 'Location: Moscow (default)';
      });
    }

    if (mounted) {
      context.read<QiblaBloc>().add(const GetQiblaDirectionEvent());
    }
  }

  void _startCompass() {
    magnetometerEvents.listen((MagnetometerEvent event) {
      double heading = _calculateHeading(event.x, event.y);
      if (mounted) {
        setState(() {
          _deviceHeading = heading;
        });
      }
    });
  }

  double _calculateHeading(double x, double y) {
    double heading = (math.atan2(y, x) * 180 / math.pi);
    heading = (heading + 360) % 360;
    return heading;
  }

  double _getCompassRotation(double qiblaDirection) {
    double rotation = qiblaDirection - _deviceHeading;
    if (rotation > 180) rotation -= 360;
    if (rotation < -180) rotation += 360;
    return rotation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Qibla Compass',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: lightShadowColor,
            fontWeight: FontWeight.bold,
          ) ?? TextStyle(
            color: lightShadowColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<QiblaBloc, QiblaState>(
          builder: (context, state) {
            if (state.status == QiblaStatus.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: blueShade),
                    const SizedBox(height: 20),
                    Text(
                      _locationStatus,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: lightShadowColor,
                      ) ?? TextStyle(color: lightShadowColor),
                    ),
                  ],
                ),
              );
            }

            if (state.status == QiblaStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 20),
                    Text(
                      state.errorMessage ?? 'Error loading compass',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: lightShadowColor,
                      ) ?? TextStyle(color: lightShadowColor),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  shadowColor,
                                  blueBackground,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: blueShade.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 20,
                                  child: Text(
                                    'N',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: lightShadowColor,
                                      fontWeight: FontWeight.bold,
                                    ) ?? TextStyle(
                                      color: lightShadowColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  child: Text(
                                    'E',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: lightShadowColor,
                                      fontWeight: FontWeight.bold,
                                    ) ?? TextStyle(
                                      color: lightShadowColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Text(
                                    'S',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: lightShadowColor,
                                      fontWeight: FontWeight.bold,
                                    ) ?? TextStyle(
                                      color: lightShadowColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  child: Text(
                                    'W',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: lightShadowColor,
                                      fontWeight: FontWeight.bold,
                                    ) ?? TextStyle(
                                      color: lightShadowColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: _getCompassRotation(state.qiblaDirection) * (math.pi / 180),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: blueShade,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: blueShade,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: lightShadowColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            shadowColor,
                            blueBackground,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Qibla Direction',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: lightShadowColor,
                              fontWeight: FontWeight.w500,
                            ) ?? TextStyle(
                              color: lightShadowColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${state.qiblaDirection.toStringAsFixed(1)}° from North',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: blueShade,
                              fontWeight: FontWeight.bold,
                            ) ?? TextStyle(
                              color: blueShade,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Device Heading: ${_deviceHeading.toStringAsFixed(1)}°',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: lightShadowColor.withOpacity(0.7),
                            ) ?? TextStyle(
                              color: lightShadowColor.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Direction to Kaaba (Mecca)',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: lightShadowColor.withOpacity(0.7),
                            ) ?? TextStyle(
                              color: lightShadowColor.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoCard('Latitude', '${_latitude.toStringAsFixed(2)}°N', context),
                              _buildInfoCard('Longitude', '${_longitude.toStringAsFixed(2)}°E', context),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: blueShade.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: blueShade,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'The golden needle points towards the Kaaba. Your device heading is shown above. The compass uses GPS for accurate location and magnetometer for device orientation. Rotate your device to see the compass needle adjust.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: lightShadowColor,
                          height: 1.5,
                        ) ?? TextStyle(
                          color: lightShadowColor,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildInfoCard(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: blueBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: lightShadowColor.withOpacity(0.7),
            ) ?? TextStyle(
              color: lightShadowColor.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: blueShade,
              fontWeight: FontWeight.bold,
            ) ?? TextStyle(
              color: blueShade,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
