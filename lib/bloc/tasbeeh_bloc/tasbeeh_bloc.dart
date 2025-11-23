import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasbeeh_event.dart';
import 'tasbeeh_state.dart';

class TasbeehBloc extends Bloc<TasbeehEvent, TasbeehState> {
  TasbeehBloc() : super(TasbeehState()) {
    on<LoadTasbeehEvent>(_onLoadTasbeeh);
    on<IncrementTasbeehCounterEvent>(_onIncrementCounter);
    on<ResetTasbeehCounterEvent>(_onResetCounter);
    on<AddCustomTasbeehEvent>(_onAddCustomTasbeeh);
    on<RemoveCustomTasbeehEvent>(_onRemoveCustomTasbeeh);
    on<CompleteTasbeehEvent>(_onCompleteTasbeeh);
    on<GetTasbeehHistoryEvent>(_onGetHistory);
  }

  final List<Tasbeeh> _defaultTasbeehs = [
    Tasbeeh(
      id: 1,
      text: 'Subhan\'Allah (Glory be to Allah)',
      currentCount: 0,
      targetCount: 33,
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
    Tasbeeh(
      id: 2,
      text: 'Al-hamdu lillah (Praise be to Allah)',
      currentCount: 0,
      targetCount: 33,
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
    Tasbeeh(
      id: 3,
      text: 'Allahu Akbar (Allah is the Greatest)',
      currentCount: 0,
      targetCount: 33,
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
    Tasbeeh(
      id: 4,
      text: 'La ilaha illallah (There is no god but Allah)',
      currentCount: 0,
      targetCount: 100,
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
  ];

  Future<void> _onLoadTasbeeh(LoadTasbeehEvent event, Emitter<TasbeehState> emit) async {
    emit(state.copyWith(status: TasbeehStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        tasbeehs: _defaultTasbeehs,
        status: TasbeehStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onIncrementCounter(
      IncrementTasbeehCounterEvent event, Emitter<TasbeehState> emit) async {
    try {
      final updatedTasbeehs = state.tasbeehs.map((tasbeeh) {
        if (tasbeeh.id == event.taskbeehId && !tasbeeh.isCompleted) {
          final newCount = tasbeeh.currentCount + 1;
          final isNowCompleted = newCount >= tasbeeh.targetCount;
          return tasbeeh.copyWith(
            currentCount: newCount,
            isCompleted: isNowCompleted,
            completedAt: isNowCompleted ? DateTime.now() : null,
          );
        }
        return tasbeeh;
      }).toList();
      emit(state.copyWith(tasbeehs: updatedTasbeehs));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onResetCounter(ResetTasbeehCounterEvent event, Emitter<TasbeehState> emit) async {
    try {
      final updatedTasbeehs = state.tasbeehs.map((tasbeeh) {
        if (tasbeeh.id == event.tasbeehId) {
          return tasbeeh.copyWith(
            currentCount: 0,
            isCompleted: false,
            completedAt: null,
          );
        }
        return tasbeeh;
      }).toList();
      emit(state.copyWith(tasbeehs: updatedTasbeehs));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAddCustomTasbeeh(
      AddCustomTasbeehEvent event, Emitter<TasbeehState> emit) async {
    try {
      final newId = (state.tasbeehs.isEmpty ? 0 : state.tasbeehs.last.id) + 1;
      final newTasbeeh = Tasbeeh(
        id: newId,
        text: event.tasbeehText,
        currentCount: 0,
        targetCount: event.targetCount,
        isCompleted: false,
        createdAt: DateTime.now(),
        isCustom: true,
      );
      final updatedTasbeehs = [...state.tasbeehs, newTasbeeh];
      emit(state.copyWith(tasbeehs: updatedTasbeehs));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveCustomTasbeeh(
      RemoveCustomTasbeehEvent event, Emitter<TasbeehState> emit) async {
    try {
      final updatedTasbeehs = state.tasbeehs.where((t) => t.id != event.tasbeehId).toList();
      emit(state.copyWith(tasbeehs: updatedTasbeehs));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCompleteTasbeeh(CompleteTasbeehEvent event, Emitter<TasbeehState> emit) async {
    try {
      final tasbeeh = state.tasbeehs.firstWhere((t) => t.id == event.tasbeehId);
      final updatedTasbeehs =
          state.tasbeehs.where((t) => t.id != event.tasbeehId).toList();
      final updatedCompleted = [
        ...state.completedTasbeehs,
        tasbeeh.copyWith(isCompleted: true, completedAt: DateTime.now()),
      ];
      emit(state.copyWith(
        tasbeehs: updatedTasbeehs,
        completedTasbeehs: updatedCompleted,
        totalCompletions: state.totalCompletions + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGetHistory(GetTasbeehHistoryEvent event, Emitter<TasbeehState> emit) async {
    emit(state.copyWith(status: TasbeehStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(status: TasbeehStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: TasbeehStatus.error,
        error: e.toString(),
      ));
    }
  }
}
