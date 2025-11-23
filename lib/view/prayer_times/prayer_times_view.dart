import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/prayer_times_bloc/prayer_times_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({super.key});

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  @override
  void initState() {
    super.initState();
    // Москва координаты
    context.read<PrayerTimesBloc>().add(const GetPrayerTimesEvent(55.7558, 37.6173));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Prayer Times',
          style: TextStyle(
            color: lightShadowColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<PrayerTimesBloc, PrayerTimesState>(
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
                            style: TextStyle(
                              color: lightShadowColor.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.nextPrayer ?? 'N/A',
                            style: TextStyle(
                              color: lightShadowColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'in ${state.timeUntilNextPrayer ?? '0:00'}',
                            style: TextStyle(
                              color: lightShadowColor.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Prayer Times List
                    Text(
                      'Today\'s Prayer Times',
                      style: TextStyle(
                        color: lightShadowColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                                  style: TextStyle(
                                    color: lightShadowColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  prayer.arabicName,
                                  style: TextStyle(
                                    color: blueShade,
                                    fontSize: 12,
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
                                style: TextStyle(
                                  color: blueShade,
                                  fontSize: 16,
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
