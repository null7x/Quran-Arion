import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/islamic_calendar_bloc/islamic_calendar_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class IslamicCalendarView extends StatefulWidget {
  const IslamicCalendarView({Key? key}) : super(key: key);

  @override
  State<IslamicCalendarView> createState() => _IslamicCalendarViewState();
}

class _IslamicCalendarViewState extends State<IslamicCalendarView> {
  @override
  void initState() {
    super.initState();
    context.read<IslamicCalendarBloc>().add(const GetCurrentIslamicDateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('Islamic Calendar'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<IslamicCalendarBloc, IslamicCalendarState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD4AF37),
              ),
            );
          }

          if (state.islamicDate == null) {
            return Center(
              child: Text(
                'Unable to load calendar',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.lightShadowColor,
                    ),
              ),
            );
          }

          final islamicDate = state.islamicDate!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Current Islamic Date Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blueShade, AppColors.backgroundColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Today\'s Islamic Date',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightShadowColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      islamicDate.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE8D5B7),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${islamicDate.dayName}, ${state.gregorianDate?.toString().split(' ')[0] ?? 'N/A'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.shadowColor,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Upcoming Holidays Section
              Text(
                'Important Islamic Dates',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.lightShadowColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              state.holidays.isEmpty
                  ? Center(
                      child: Text(
                        'No upcoming holidays this year',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.shadowColor,
                            ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.holidays.length,
                      itemBuilder: (context, index) {
                        final holiday = state.holidays[index];
                        return Card(
                          color: AppColors.backgroundColor,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.blueShade,
                                      child: Icon(
                                        Icons.star,
                                        color: AppColors.lightShadowColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            holiday.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: AppColors.lightShadowColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            '${holiday.day} ${IslamicCalendarBloc.hijriMonths[holiday.month - 1]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.blueShade,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  holiday.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.shadowColor,
                                        height: 1.5,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<IslamicCalendarBloc>()
              .add(const GetCurrentIslamicDateEvent());
        },
        backgroundColor: AppColors.blueShade,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
