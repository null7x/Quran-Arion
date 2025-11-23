import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/duas_bloc/duas_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

class DuasView extends StatefulWidget {
  const DuasView({Key? key}) : super(key: key);

  @override
  State<DuasView> createState() => _DuasViewState();
}

class _DuasViewState extends State<DuasView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<DuasBloc>().add(const GetCategoriesEvent());
    context.read<DuasBloc>().add(const GetDuasEvent());
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
        title: const Text('Islamic Duas'),
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
                    context.read<DuasBloc>().add(const GetDuasEvent());
                  } else {
                    context.read<DuasBloc>().add(SearchDuasEvent(query));
                  }
                },
                style: TextStyle(color: AppColors.lightShadowColor),
                decoration: InputDecoration(
                  hintText: 'Search duas...',
                  hintStyle: TextStyle(color: AppColors.shadowColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.search, color: AppColors.blueShade),
                ),
              ),
            ),
          ),

          // Categories Horizontal Scroll
          BlocBuilder<DuasBloc, DuasState>(
            builder: (context, state) {
              if (state.categories.isEmpty) {
                return const SizedBox.shrink();
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All'),
                        selected: state.selectedCategory == null,
                        onSelected: (selected) {
                          if (selected) {
                            _searchController.clear();
                            context
                                .read<DuasBloc>()
                                .add(const GetDuasEvent());
                          }
                        },
                        backgroundColor: AppColors.backgroundColor,
                        selectedColor: AppColors.blueShade,
                        labelStyle: TextStyle(
                          color: state.selectedCategory == null
                              ? AppColors.lightShadowColor
                              : AppColors.lightShadowColor,
                        ),
                      ),
                    ),
                    ...state.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: state.selectedCategory == category,
                          onSelected: (selected) {
                            if (selected) {
                              _searchController.clear();
                              context
                                  .read<DuasBloc>()
                                  .add(GetDuasEvent(category: category));
                            }
                          },
                          backgroundColor: AppColors.backgroundColor,
                          selectedColor: AppColors.blueShade,
                          labelStyle: TextStyle(
                            color: state.selectedCategory == category
                                ? AppColors.lightShadowColor
                                : AppColors.shadowColor,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Duas List
          Expanded(
            child: BlocBuilder<DuasBloc, DuasState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD4AF37),
                    ),
                  );
                }

                if (state.duas.isEmpty) {
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
                          'No duas found',
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
                  itemCount: state.duas.length,
                  itemBuilder: (context, index) {
                    final dua = state.duas[index];
                    return Card(
                      color: AppColors.backgroundColor,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        title: Text(
                          dua.arabicText,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: AppColors.lightShadowColor,
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Chip(
                            label: Text(dua.category),
                            backgroundColor: AppColors.blueShade,
                            labelStyle: TextStyle(
                              color: AppColors.lightShadowColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTranslationSection(
                                  context,
                                  'English Translation',
                                  dua.englishTranslation,
                                ),
                                const SizedBox(height: 16),
                                _buildTranslationSection(
                                  context,
                                  'Russian Translation',
                                  dua.russianTranslation,
                                ),
                                if (dua.benefits != null) ...[
                                  const SizedBox(height: 16),
                                  _buildBenefitsSection(
                                    context,
                                    dua.benefits!,
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationSection(
    BuildContext context,
    String title,
    String text,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blueShade,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.lightShadowColor,
                height: 1.6,
              ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection(BuildContext context, String benefits) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blueBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: AppColors.blueShade,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              benefits,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.shadowColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
