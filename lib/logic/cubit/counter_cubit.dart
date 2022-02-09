import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counting_while_nointernet/constants/enums.dart';
import 'package:counting_while_nointernet/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

int initValue = 0;

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: initValue)) {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(CounterState(counterValue: state.counterValue + 1));

  void decrement() => emit(CounterState(counterValue: state.counterValue - 1));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
