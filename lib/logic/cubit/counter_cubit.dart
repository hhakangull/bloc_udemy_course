import 'dart:async';

import 'package:bloc_udemy_course/constants/enums.dart';
import 'package:bloc_udemy_course/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit}) : super(CounterState(counterValue: 0)) {
    internetStreamSubscription = monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected && internetState.connectionType == ConnectionType.wifi) {
        increment();
      } else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
