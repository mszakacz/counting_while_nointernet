part of 'counter_cubit.dart';

class CounterState extends Equatable {
  int counterValue;
  CounterState({required this.counterValue});

  @override
  List<Object?> get props => [counterValue];
}
