import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_and_bloc/my_bloc.dart';
import 'package:get_it_and_bloc/my_get_it.dart';

void main() {
  MyGetIt.getItSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late CounterBloc counterBloc;

  @override
  void initState() {
    counterBloc = MyGetIt.getIt<CounterBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: Column(
          children: [
            BlocProvider(
              create: (_) => counterBloc,
              child: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Text('First page counter: $state');
                },
              ),
            ),
            ElevatedButton(
              child: const Icon(Icons.add),
              onPressed: () => counterBloc.incremenet(),
            ),
            ElevatedButton(
              child: const Icon(Icons.new_label),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (context) => SecondPage(counterBloc: counterBloc),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.counterBloc});

  final CounterBloc counterBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          children: [
            BlocProvider(
              create: (_) => counterBloc,
              child: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Text('First page counter: $state');
                },
              ),
            ),
            ElevatedButton(
              onPressed: counterBloc.decremenet,
              child: const Icon(Icons.expand_less),
            ),
          ],
        ),
      ),
    );
  }
}
