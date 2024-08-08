import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/fetch_all_coins_bloc/fetch_all_coins_bloc.dart';
import 'bloc/fetch_coin_chart_bloc/fetch_coin_chart_bloc.dart';
import 'page/home_page.dart';

void main() {
  runZonedGuarded(
    () => runApp(const MainApp()),
    (error, stack) => log("$error: $stack"),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchAllCoinsBloc>(
            create: (context) => FetchAllCoinsBloc()),
        BlocProvider<FetchCoinChartBloc>(
            create: (context) => FetchCoinChartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}
