import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_cases/get_counter_use_case.dart';
import '../../../../domain/use_cases/get_name_use_case.dart';
import '../../../../domain/use_cases/save_counter_use_case.dart';

part 'my_home_event.dart';
part 'my_home_state.dart';

class MyHomeBloc extends Bloc<MyHomeEvent, MyHomeState> {
  final GetCounterUseCase _getCounterUseCase;
  final SaveCounterUseCase _saveCounterUseCase;
  final GetNameUseCase _getNameUseCase;

  MyHomeBloc(
    this._getCounterUseCase,
    this._saveCounterUseCase,
    this._getNameUseCase,
  ) : super(const MyHomeState()) {
    on<LoadMyHomeEvent>(_loadData);
    on<IncrementHomeEvent>(_increment);
    on<SubtractHomeEvent>(_subtract);
    on<ResetHomeEvent>(_reset);
  }

  Future<void> _loadData(
    LoadMyHomeEvent event,
    Emitter<MyHomeState> emit,
  ) async {
    final counter = await _getCounterUseCase.call();
    final name = await _getNameUseCase.call();

    int? currentCounter = state.counter;
    String? currentName = state.name;
    MyHomeStatus currentStatus = state.status;

    counter.fold(
      ifLeft: (error) => currentStatus = MyHomeStatus.error,
      ifRight: (value) {
        currentCounter = value;
        currentStatus = MyHomeStatus.loaded;
      },
    );

    name.fold(
      ifLeft: (error) => currentStatus = MyHomeStatus.error,
      ifRight: (value) {
        currentName = value;
        currentStatus = MyHomeStatus.loaded;
      },
    );

    emit(
      state.copyWith(
        status: currentStatus,
        counter: currentCounter,
        name: currentName,
      ),
    );
  }

  Future<void> _increment(
    IncrementHomeEvent event,
    Emitter<MyHomeState> emit,
  ) async {
    final int newCounter = state.counter + 1;
    final saveCounter = await _saveCounterUseCase.call(newCounter);

    saveCounter.fold(
      ifLeft: (error) => emit(state.copyWith(status: MyHomeStatus.error)),
      ifRight: (_) {
        emit(
          state.copyWith(
            status: MyHomeStatus.loaded,
            counter: newCounter,
            lista: _alterarLista('Aumentou'),
          ),
        );
      },
    );
  }

  Future<void> _subtract(
    SubtractHomeEvent event,
    Emitter<MyHomeState> emit,
  ) async {
    if (state.counter > 0) {
      final int newCounter = state.counter - 1;
      final saveCounter = await _saveCounterUseCase.call(newCounter);

      saveCounter.fold(
        ifLeft: (error) => emit(state.copyWith(status: MyHomeStatus.error)),
        ifRight: (_) {
          emit(
            state.copyWith(
              status: MyHomeStatus.loaded,
              counter: newCounter,
              lista: _alterarLista('Diminuiu'),
            ),
          );
        },
      );
    }
  }

  Future<void> _reset(ResetHomeEvent event, Emitter<MyHomeState> emit) async {
    final int newCounter = 0;
    final saveCounter = await _saveCounterUseCase.call(newCounter);

    saveCounter.fold(
      ifLeft: (error) => emit(state.copyWith(status: MyHomeStatus.error)),
      ifRight: (_) {
        emit(
          state.copyWith(
            status: MyHomeStatus.loaded,
            counter: newCounter,
            lista: _alterarLista('Resetou'),
          ),
        );
      },
    );
  }

  List<String> _alterarLista(String operador) {
    final novaLista = List<String>.from(state.lista);
    novaLista.insert(0, operador);

    if (novaLista.length > 5) {
      novaLista.removeLast();
    }
    return novaLista;
  }
}
