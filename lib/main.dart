import 'package:bloc_udemy_course/logic/cubit/counter_cubit.dart';
import 'package:bloc_udemy_course/logic/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/router/app_router.dart';

void main() {
  Connectivity connectivity = Connectivity();
  InternetCubit internetCubit = InternetCubit(connectivity: connectivity);
  runApp(MyApp(
    appRouter: AppRouter(internetCubit: internetCubit),
    internetCubit: InternetCubit(connectivity: connectivity),
    connectivity: connectivity,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  final InternetCubit internetCubit;
  const MyApp({
    super.key,
    required this.appRouter,
    required this.connectivity,
    required this.internetCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(create: (context) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(create: (context) => CounterCubit(internetCubit: context.read<InternetCubit>()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
