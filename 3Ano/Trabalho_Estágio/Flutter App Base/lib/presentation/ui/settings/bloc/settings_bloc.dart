import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/get_name_use_case.dart';
import '../../../../domain/use_cases/save_name_use_case.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetNameUseCase _getNameUseCase;
  final SaveNameUseCase _saveNameUseCase;

  SettingsBloc(this._getNameUseCase, this._saveNameUseCase)
    : super(const SettingsState()) {
    on<LoadSettingsEvent>(_loadData);
    on<SaveDataSettingsEvent>(_saveData);
    on<ClearDataSettingsEvent>(_clearData);
  }

  Future<void> _loadData(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final name = await _getNameUseCase.call();
    String? currentName = state.name;
    SettingsStatus currentStatus = state.status;

    name.fold(
      ifLeft: (error) => currentStatus = SettingsStatus.error,
      ifRight: (value) {
        currentName = value;
        currentStatus = SettingsStatus.loaded;
      },
    );

    emit(state.copyWith(status: currentStatus, name: currentName));
  }

  Future<void> _saveData(
    SaveDataSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final saveName = await _saveNameUseCase.call(event.name);

    saveName.fold(
      ifLeft: (error) => emit(state.copyWith(status: SettingsStatus.error)),
      ifRight: (_) {
        emit(state.copyWith(status: SettingsStatus.loaded, name: event.name));
      },
    );
  }

  Future<void> _clearData(
    ClearDataSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final saveName = await _saveNameUseCase.call('');

    saveName.fold(
      ifLeft: (error) => emit(state.copyWith(status: SettingsStatus.error)),
      ifRight: (_) {
        emit(state.copyWith(status: SettingsStatus.loaded, name: ''));
      },
    );
  }
}
