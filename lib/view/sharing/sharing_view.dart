import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sharing_bloc/sharing_bloc.dart';
import '../../bloc/sharing_bloc/sharing_event.dart';
import '../../bloc/sharing_bloc/sharing_state.dart';
import '../../res/app_colors.dart';

class SharingView extends StatefulWidget {
  const SharingView({Key? key}) : super(key: key);

  @override
  State<SharingView> createState() => _SharingViewState();
}

class _SharingViewState extends State<SharingView> {
  @override
  void initState() {
    super.initState();
    context.read<SharingBloc>().add(LoadSharingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community & Sharing'),
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
      ),
      body: BlocBuilder<SharingBloc, SharingState>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: AppColors.darkGreen,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.darkGreen,
                  tabs: const [
                    Tab(text: 'Community'),
                    Tab(text: 'My Shares'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildCommunityTab(state),
                      _buildMySharesTab(state),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommunityTab(SharingState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (state.communityUsers.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No community members found'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.communityUsers.length,
              itemBuilder: (context, index) {
                final user = state.communityUsers[index];
                final isFollowing = state.userFollowing.contains(user.userId);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.darkGreen,
                                  child: Text(
                                    user.name.isNotEmpty ? user.name[0] : '?',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${user.followers} followers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isFollowing
                                    ? Colors.grey.shade400
                                    : AppColors.darkGreen,
                              ),
                              onPressed: () {
                                context
                                    .read<SharingBloc>()
                                    .add(FollowUserEvent(user.userId));
                              },
                              child: Text(isFollowing ? 'Following' : 'Follow'),
                            ),
                          ],
                        ),
                        if (user.sharedVerses.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          const Divider(),
                          ...user.sharedVerses.map((verse) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Surah ${verse.surahNumber}:${verse.ayahNumber}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    verse.translation,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.favorite_border, size: 16),
                                      const SizedBox(width: 4),
                                      Text('${verse.likes}'),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.comment_outlined, size: 16),
                                      const SizedBox(width: 4),
                                      Text('${verse.comments.length}'),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMySharesTab(SharingState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Shares: ${state.totalShares}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                if (state.sharedVerses.isEmpty)
                  const Text('No verses shared yet')
                else
                  ...state.sharedVerses.map((verse) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Surah ${verse.surahNumber}:${verse.ayahNumber}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              verse.translation,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.favorite, color: Colors.red),
                                    const SizedBox(width: 4),
                                    Text('${verse.likes}'),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.comment),
                                    const SizedBox(width: 4),
                                    Text('${verse.comments.length}'),
                                  ],
                                ),
                                Text(
                                  _formatTime(verse.sharedAt),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
