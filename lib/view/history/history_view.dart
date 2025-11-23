import 'package:flutter/material.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<PlaybackHistoryItem> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    // Load history from shared preferences or database
    // For now, we'll use mock data
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _history = [
        PlaybackHistoryItem(
          title: 'Surah Al-Fatihah',
          qari: 'Muhammad Al-Minshawi',
          duration: Duration(minutes: 4, seconds: 33),
          playedAt: DateTime.now().subtract(const Duration(hours: 2)),
          imageUrl: null,
        ),
        PlaybackHistoryItem(
          title: 'Surah Al-Baqarah',
          qari: 'Abdul Basit Abdus Samad',
          duration: Duration(minutes: 40, seconds: 15),
          playedAt: DateTime.now().subtract(const Duration(hours: 5)),
          imageUrl: null,
        ),
        PlaybackHistoryItem(
          title: 'Surah Yasin',
          qari: 'Mishary Alafasy',
          duration: Duration(minutes: 31, seconds: 5),
          playedAt: DateTime.now().subtract(const Duration(days: 1)),
          imageUrl: null,
        ),
        PlaybackHistoryItem(
          title: 'Surah Al-Ahzab',
          qari: 'Saad Al-Ghamdi',
          duration: Duration(minutes: 26, seconds: 42),
          playedAt: DateTime.now().subtract(const Duration(days: 2)),
          imageUrl: null,
        ),
      ];
      _isLoading = false;
    });
  }

  Future<void> _clearHistory() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: shadowColor,
        title: Text(
          'Clear History',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: lightShadowColor,
          ) ?? TextStyle(color: lightShadowColor),
        ),
        content: Text(
          'Are you sure you want to clear all playback history?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: lightShadowColor.withOpacity(0.8),
          ) ?? TextStyle(color: lightShadowColor.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: blueShade,
              ) ?? TextStyle(color: blueShade),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _history.clear());
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'History cleared',
                    style: Theme.of(context).textTheme.bodySmall ?? const TextStyle(),
                  ),
                  backgroundColor: blueShade,
                ),
              );
            },
            child: Text(
              'Clear',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.red,
              ) ?? TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Playback History',
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
        actions: [
          if (_history.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_outline, color: lightShadowColor),
              onPressed: _clearHistory,
              tooltip: 'Clear history',
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: blueShade),
              )
            : _history.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 80,
                          color: blueShade.withOpacity(0.3),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No playback history',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: lightShadowColor,
                          ) ?? TextStyle(color: lightShadowColor, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Your playback history will appear here',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: lightShadowColor.withOpacity(0.6),
                          ) ?? TextStyle(
                            color: lightShadowColor.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      final item = _history[index];
                      return _buildHistoryCard(context, item, index);
                    },
                  ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, PlaybackHistoryItem item, int index) {
    final timeAgo = _getTimeAgoString(item.playedAt);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              shadowColor,
              blueBackground,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: blueShade.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.music_note,
                color: blueShade,
                size: 32,
              ),
            ),
          ),
          title: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: lightShadowColor,
              fontWeight: FontWeight.w600,
            ) ?? TextStyle(
              color: lightShadowColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                item.qari,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: lightShadowColor.withOpacity(0.7),
                ) ?? TextStyle(
                  color: lightShadowColor.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    _formatDuration(item.duration),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: blueShade,
                    ) ?? TextStyle(
                      color: blueShade,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: lightShadowColor.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeAgo,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: lightShadowColor.withOpacity(0.5),
                    ) ?? TextStyle(
                      color: lightShadowColor.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: PopupMenuButton(
            color: shadowColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Play',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: lightShadowColor,
                  ) ?? TextStyle(color: lightShadowColor),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Playing: ${item.title}',
                        style: Theme.of(context).textTheme.bodySmall ?? const TextStyle(),
                      ),
                      backgroundColor: blueShade,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: Text(
                  'Remove',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                  ) ?? TextStyle(color: Colors.red),
                ),
                onTap: () {
                  setState(() => _history.removeAt(index));
                },
              ),
            ],
            child: Icon(
              Icons.more_vert,
              color: lightShadowColor.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _getTimeAgoString(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}

class PlaybackHistoryItem {
  final String title;
  final String qari;
  final Duration duration;
  final DateTime playedAt;
  final String? imageUrl;

  PlaybackHistoryItem({
    required this.title,
    required this.qari,
    required this.duration,
    required this.playedAt,
    this.imageUrl,
  });
}
