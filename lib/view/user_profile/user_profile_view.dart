import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:quran_arion/utils/translations.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/res/app_colors.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    context.read<UserProfileBloc>().add(const LoadUserProfileEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: Text(Translations.get('profile')),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state.status == Status.loading && state.profile == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFD4AF37),
              ),
            );
          }

          if (state.profile == null) {
            return Center(
              child: Text(
                Translations.get('unableToLoadProfile'),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.lightShadowColor,
                    ),
              ),
            );
          }

          final profile = state.profile!;
          _nameController.text = profile.name;
          _emailController.text = profile.email;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Profile Header
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.blueShade,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.lightShadowColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name and Email Fields
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 24),

              // Update Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  context.read<UserProfileBloc>().add(
                        UpdateUserProfileEvent(
                          name: _nameController.text,
                          email: _emailController.text,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: Color(0xFFD4AF37),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Update Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueShade,
                  foregroundColor: AppColors.lightShadowColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 32),

              // Statistics Section
              Text(
                'Statistics',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.lightShadowColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Statistics Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard(
                    context,
                    'Total Surahs Completed',
                    profile.totalSurahs.toString(),
                    Icons.book,
                  ),
                  _buildStatCard(
                    context,
                    'Listening Hours',
                    profile.listeningHours.toString(),
                    Icons.timer,
                  ),
                  _buildStatCard(
                    context,
                    'Favorite Surahs',
                    profile.favoriteCount.toString(),
                    Icons.favorite,
                  ),
                  _buildStatCard(
                    context,
                    'Current Streak (Days)',
                    profile.currentStreak.toString(),
                    Icons.local_fire_department,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Member Since
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blueShade, width: 1),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Member Since',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.blueShade,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(profile.joinDate),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.lightShadowColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Reset Statistics Button
              OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: AppColors.backgroundColor,
                      title: Text(
                        'Reset Statistics?',
                        style: TextStyle(color: AppColors.lightShadowColor),
                      ),
                      content: Text(
                        'Are you sure you want to reset all your statistics?',
                        style: TextStyle(color: AppColors.shadowColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.blueShade),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<UserProfileBloc>()
                                .add(const ResetStatisticsEvent());
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Statistics'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.lightShadowColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.blueShade),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: Icon(icon, color: AppColors.blueShade),
        ),
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
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.blueShade, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.lightShadowColor,
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
