import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_arion/bloc/prayer_times_bloc/prayer_times_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({super.key});

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  double _latitude = 55.7558; // Default: Moscow
  double _longitude = 37.6173;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _requestLocationAndGetPrayerTimes();
  }

  Future<void> _requestLocationAndGetPrayerTimes() async {
    try {
      // Request location permission
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
          });
        } catch (e) {
          // Use default if getting location fails
          setState(() {
            _isLoadingLocation = false;
          });
        }
      } else {
        // Use default if permission denied
        setState(() {
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      // Use default on any error
      setState(() {
        _isLoadingLocation = false;
      });
    }

    // Get prayer times with the determined location
    if (mounted) {
      context.read<PrayerTimesBloc>().add(
        GetPrayerTimesEvent(latitude: _latitude, longitude: _longitude),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Prayer Times',
          style: textTheme.headlineMedium?.copyWith(
            color: lightShadowColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _isLoadingLocation
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: blueShade),
                      const SizedBox(height: 16),
                      Text(
                        'Getting your location...',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
                  builder: (context, state) {
                    if (state.status == Status.loading) {
                      return Center(
                        child: CircularProgressIndicator(color: blueShade),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Next Prayer Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [blueShade, blueShade.withOpacity(0.7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: blueShade.withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Next Prayer',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: lightShadowColor.withOpacity(0.8),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.nextPrayer ?? 'N/A',
                                  style: textTheme.headlineLarge?.copyWith(
                                    color: lightShadowColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'in ${state.timeUntilNextPrayer ?? '0:00'}',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: lightShadowColor.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Prayer Times List
                          Text(
                            'Today\'s Prayer Times',
                            style: textTheme.titleMedium?.copyWith(
                              color: lightShadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Latitude: ${_latitude.toStringAsFixed(4)}, Longitude: ${_longitude.toStringAsFixed(4)}',
                            style: textTheme.bodySmall?.copyWith(
                              color: lightShadowColor.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ...state.prayerTimes.map((prayer) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [shadowColor, blueBackground],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        prayer.name,
                                        style: textTheme.titleSmall?.copyWith(
                                          color: lightShadowColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        prayer.arabicName,
                                        style: textTheme.bodySmall?.copyWith(
                                          color: blueShade,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: blueShade.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      prayer.time,
                                      style: textTheme.titleSmall?.copyWith(
                                        color: blueShade,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
