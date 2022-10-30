import 'package:bloc_udemy_course/constants/enums.dart';
import 'package:bloc_udemy_course/logic/cubit/counter_cubit.dart';
import 'package:bloc_udemy_course/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, this.color});

  final String title;
  final Color? color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color ?? Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.wifi) {
                  return const Text('Wifi');
                } else if (state is InternetConnected && state.connectionType == ConnectionType.mobile) {
                  return const Text('Mobile');
                } else if (state is InternetDisConnected) {
                  return const Text('Disconnected');
                }
                return const CircularProgressIndicator();
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'COUNTER VALUE',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  //tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  // tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () => Navigator.of(context).pushNamed('/second'),
              child: const Text(
                'Go to Second Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Colors.greenAccent,
              onPressed: () => Navigator.of(context).pushNamed('/third'),
              child: const Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
