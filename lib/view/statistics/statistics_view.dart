import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/statistics_bloc/statistics_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  void initState() {
    super.initState();
    context.read<StatisticsBloc>().add(const LoadStatisticsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('Statistics Dashboard'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          final stats = state.statistics;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Main Stats Cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildStatCard(
                    context,
                    'Total Hours',
                    '${stats.totalListeningHours}h',
                    Icons.timer,
                  ),
                  _buildStatCard(
                    context,
                    'Surahs Listened',
                    '${stats.totalSurahsListened}',
                    Icons.menu_book,
                  ),
                  _buildStatCard(
                    context,
                    'Current Streak',
                    '${stats.currentStreak}',
                    Icons.local_fire_department,
                  ),
                  _buildStatCard(
                    context,
                    'Best Streak',
                    '${stats.longestStreak}',
                    Icons.star,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Last 7 Days Activity
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.lightShadowColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              _buildActivityBar(context),
              const SizedBox(height: 32),

              // Top Surahs
              Text(
                'Most Listened Surahs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.lightShadowColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              stats.surahPlayCounts.isEmpty
                  ? Center(
                      child: Text(
                        'No listening history yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.shadowColor,
                            ),
                      ),
                    )
                  : Column(
                      children: stats.surahPlayCounts.entries
                          .toList()
                          .take(5)
                          .map((entry) => _buildSurahItem(
                                context,
                                'Surah ${entry.key}',
                                '${entry.value} times',
                              ))
                          .toList(),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blueShade, AppColors.backgroundColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFFD4AF37), size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.shadowColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => Column(
          children: [
            Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.blueShade.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '${(index + 1) * 2}',
                  style: TextStyle(
                    color: AppColors.blueShade,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              days[index],
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.shadowColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahItem(
    BuildContext context,
    String title,
    String count,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.lightShadowColor,
                ),
          ),
          Chip(
            label: Text(count),
            backgroundColor: AppColors.blueShade,
            labelStyle: TextStyle(color: AppColors.lightShadowColor),
          ),
        ],
      ),
    );
  }
}
