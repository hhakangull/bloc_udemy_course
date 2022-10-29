import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_udemy_course/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCounterCubit extends MockCubit<CounterState> implements CounterCubit {}

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit = CounterCubit();
    //final counterBloc = MockCounterCubit();
    setUp(() {});

    tearDown(() {
      counterCubit.close();
    });

    test('the initial state for CounterCubit is CounterState(counterValue:0)', () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });

    blocTest(
        'the cubit should emit a CounterState(counterValue:1, wasIncremented:true) when cubit.increment() function is called',
        build: () => CounterCubit(),
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest(
        'the cubit should emit a CounterState(counterValue:-1, wasIncremented:true) when cubit.decrement() function is called',
        build: () => CounterCubit(),
        act: (bloc) => bloc.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
