import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/search_bloc/search_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.blueShade, width: 1),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  if (query.isEmpty) {
                    context.read<SearchBloc>().add(const ClearSearchEvent());
                  } else {
                    context.read<SearchBloc>().add(SearchQueryEvent(query));
                  }
                },
                style: TextStyle(color: AppColors.lightShadowColor),
                decoration: InputDecoration(
                  hintText: 'Search Surahs or Qaris...',
                  hintStyle: TextStyle(color: AppColors.shadowColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.search, color: AppColors.blueShade),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: AppColors.blueShade),
                          onPressed: () {
                            _searchController.clear();
                            context
                                .read<SearchBloc>()
                                .add(const ClearSearchEvent());
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
          // Search Results
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.query.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 80,
                          color: AppColors.blueShade,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Search for Surahs or Qaris',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppColors.lightShadowColor,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD4AF37),
                    ),
                  );
                }

                if (state.results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.not_interested,
                          size: 80,
                          color: AppColors.blueShade,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No results found',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppColors.lightShadowColor,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    final result = state.results[index];
                    return Card(
                      color: AppColors.backgroundColor,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: result.type == 'surah'
                              ? AppColors.blueShade
                              : Color(0xFFD4AF37),
                          child: Icon(
                            result.type == 'surah'
                                ? Icons.book
                                : Icons.person,
                            color: AppColors.lightShadowColor,
                          ),
                        ),
                        title: Text(
                          result.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: AppColors.lightShadowColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        subtitle: Text(
                          result.subtitle ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.shadowColor,
                              ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.blueShade,
                          size: 16,
                        ),
                        onTap: () {
                          // Handle selection
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
