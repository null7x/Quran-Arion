import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('Favorite Surahs'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: AppColors.blueShade,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No favorites yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.lightShadowColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add Surahs to your favorites',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.shadowColor,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final favorite = state.favorites[index];
              return Card(
                color: AppColors.backgroundColor,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.blueShade,
                    child: Text(
                      favorite.surahNumber.toString(),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.lightShadowColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  title: Text(
                    favorite.surahName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.lightShadowColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    'Added: ${favorite.addedDate.toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.shadowColor,
                        ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: AppColors.blueShade,
                    onPressed: () {
                      context.read<FavoritesBloc>().add(
                            RemoveFavoriteEvent(favorite.surahNumber),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed ${favorite.surahName}'),
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
