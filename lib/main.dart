import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_and_bloc/my_bloc.dart';
import 'package:get_it_and_bloc/my_get_it.dart';
import 'package:intrinsic_dimension/intrinsic_dimension.dart';

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
            ElevatedButton(
              child: const Icon(Icons.new_label),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (context) => const ThirdConnectingCubes(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdConnectingCubes extends StatefulWidget {
  const ThirdConnectingCubes({super.key});

  @override
  State<ThirdConnectingCubes> createState() => _ThirdConnectingCubesState();
}

class _ThirdConnectingCubesState extends State<ThirdConnectingCubes> {
  late Offset _redOffset;
  late Offset _blueffset;
  late PreferredSizeWidget _appBar;

  @override
  void initState() {
    _appBar = AppBar(title: const Text('Intrinsic dimensions example by abel'));
    _redOffset = Offset.zero;
    _blueffset = Offset.zero;
    super.initState();
  }

  Offset _updateOffset(Offset offset) {
    return Offset(
      offset.dx,
      offset.dy -
          _appBar.preferredSize.height -
          MediaQuery.of(context).padding.top,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  IntrinsicDimension(
                    listener: (_, __, ___, offset) {
                      setState(() {
                        _redOffset = _updateOffset(offset);
                      });
                    },
                    builder: (_, __, ___, ____) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.red,
                      );
                    },
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 100),
              Row(
                children: [
                  const Spacer(),
                  IntrinsicDimension(
                    listener: (_, __, ___, offset) {
                      setState(() {
                        _blueffset = _updateOffset(offset);
                      });
                    },
                    builder: (_, __, ___, ____) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          CustomPaint(
            key: ValueKey<Offset>(_blueffset),
            painter: LinePainter(
              firstOffset: Offset(_redOffset.dx + 50, _redOffset.dy - 50),
              secondOffset: Offset(_blueffset.dx, _blueffset.dy - 100),
            ),
          )
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  const LinePainter({
    required this.firstOffset,
    required this.secondOffset,
  });

  final Offset firstOffset;
  final Offset secondOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    canvas.drawLine(firstOffset, secondOffset, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
