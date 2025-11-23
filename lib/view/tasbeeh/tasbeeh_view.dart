import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/tasbeeh_bloc/tasbeeh_bloc.dart';
import '../../bloc/tasbeeh_bloc/tasbeeh_event.dart';
import '../../bloc/tasbeeh_bloc/tasbeeh_state.dart';
import '../../res/app_colors.dart';

class TasbeehView extends StatefulWidget {
  const TasbeehView({Key? key}) : super(key: key);

  @override
  State<TasbeehView> createState() => _TasbeehViewState();
}

class _TasbeehViewState extends State<TasbeehView> {
  @override
  void initState() {
    super.initState();
    context.read<TasbeehBloc>().add(LoadTasbeehEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasbeeh Counter'),
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkGreen,
        onPressed: () {
          _showAddTasbeehDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TasbeehBloc, TasbeehState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (state.totalCompletions > 0)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 2,
                      color: AppColors.darkGreen.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Completions',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.totalCompletions}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Tasbeeh',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (state.tasbeehs.isEmpty)
                        const Text('No tasbeeh added yet')
                      else
                        ...state.tasbeehs.map((tasbeeh) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          tasbeeh.text,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                      if (tasbeeh.isCustom)
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () {
                                            context.read<TasbeehBloc>().add(
                                                  RemoveCustomTasbeehEvent(
                                                    tasbeeh.id,
                                                  ),
                                                );
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  LinearProgressIndicator(
                                    value: tasbeeh.progress,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      AppColors.darkGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${tasbeeh.currentCount}/${tasbeeh.targetCount}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkGreen,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.refresh),
                                            onPressed: () {
                                              context.read<TasbeehBloc>().add(
                                                    ResetTasbeehCounterEvent(
                                                      tasbeeh.id,
                                                    ),
                                                  );
                                            },
                                          ),
                                          if (!tasbeeh.isCompleted)
                                            ElevatedButton.icon(
                                              icon: const Icon(Icons.add),
                                              label: const Text('Tap'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.darkGreen,
                                              ),
                                              onPressed: () {
                                                context.read<TasbeehBloc>().add(
                                                      IncrementTasbeehCounterEvent(
                                                        tasbeeh.id,
                                                      ),
                                                    );
                                              },
                                            )
                                          else
                                            const Chip(
                                              label: Text('Completed'),
                                              backgroundColor:
                                                  AppColors.darkGreen,
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                        ],
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
                if (state.completedTasbeehs.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...state.completedTasbeehs
                            .map((tasbeeh) => ListTile(
                                  title: Text(tasbeeh.text),
                                  trailing: const Icon(Icons.check_circle,
                                      color: AppColors.darkGreen),
                                ))
                            .toList(),
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

  void _showAddTasbeehDialog(BuildContext context) {
    final textController = TextEditingController();
    final countController = TextEditingController(text: '33');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Tasbeeh'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Tasbeeh text',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Target count',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkGreen,
            ),
            onPressed: () {
              context.read<TasbeehBloc>().add(
                    AddCustomTasbeehEvent(
                      tasbeehText: textController.text,
                      targetCount: int.tryParse(countController.text) ?? 33,
                    ),
                  );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
