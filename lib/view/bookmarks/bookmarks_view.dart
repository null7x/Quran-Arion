import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/bookmarks_bloc/bookmarks_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({Key? key}) : super(key: key);

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    context.read<BookmarksBloc>().add(const LoadBookmarksEvent());
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('My Bookmarks'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<BookmarksBloc, BookmarksState>(
        builder: (context, state) {
          if (state.bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: AppColors.blueShade,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No bookmarks yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.lightShadowColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Save your favorite verses to Quran',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.shadowColor,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = state.bookmarks[index];
              return Card(
                color: AppColors.backgroundColor,
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(
                    '${bookmark.surahName} - Ayah ${bookmark.ayahNumber}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.lightShadowColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    'Saved: ${bookmark.dateAdded.toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.shadowColor,
                        ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () {
                      context.read<BookmarksBloc>().add(
                            RemoveBookmarkEvent(bookmark.id),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bookmark removed'),
                          backgroundColor: Color(0xFFD4AF37),
                        ),
                      );
                    },
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes:',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: AppColors.blueShade,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: TextEditingController(
                                text: bookmark.notes),
                            onChanged: (value) {
                              context.read<BookmarksBloc>().add(
                                    UpdateBookmarkEvent(bookmark.id, value),
                                  );
                            },
                            style: TextStyle(
                                color: AppColors.lightShadowColor),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Add notes...',
                              hintStyle: TextStyle(
                                  color: AppColors.shadowColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.blueShade),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.backgroundColor,
              title: Text(
                'Add Bookmark',
                style: TextStyle(color: AppColors.lightShadowColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _notesController,
                    style: TextStyle(color: AppColors.lightShadowColor),
                    decoration: InputDecoration(
                      hintText: 'Notes (optional)',
                      hintStyle: TextStyle(color: AppColors.shadowColor),
                    ),
                  ),
                ],
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
                    context.read<BookmarksBloc>().add(
                          AddBookmarkEvent(
                            surahNumber: 1,
                            ayahNumber: 1,
                            notes: _notesController.text,
                          ),
                        );
                    _notesController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: AppColors.blueShade),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: AppColors.blueShade,
        child: const Icon(Icons.add),
      ),
    );
  }
}
