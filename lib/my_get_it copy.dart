import 'package:get_it/get_it.dart';
import 'package:get_it_and_bloc/my_bloc.dart';

class MyGetIt {
  const MyGetIt._();

  static final GetIt getIt = GetIt.instance;

  ///
  static void getItSetup() {
    getIt.registerSingleton<CounterBloc>(CounterBloc());
    // registerSingleton es un objeto que va a permanecer de la misma manera
  }
}
