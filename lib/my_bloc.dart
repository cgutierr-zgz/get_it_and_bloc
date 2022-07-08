import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<int> {
  CounterBloc() : super(0);

  void incremenet() => emit(state + 1);
  void decremenet() => emit(state - 1);
}
