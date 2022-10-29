// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

// ignore: must_be_immutable
class CounterState extends Equatable {
  int counterValue;
  bool? wasIncremented;
  CounterState({required this.counterValue, this.wasIncremented});

  @override
  List<Object?> get props => [counterValue, wasIncremented];
}
