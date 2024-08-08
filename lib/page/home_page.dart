import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/bloc/fetch_all_coins_bloc/fetch_all_coins_bloc.dart';
import 'package:test_work/widgets/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fetchAllCoinsBloc = FetchAllCoinsBloc();

  @override
  void initState() {
    super.initState();
    fetchAllCoinsBloc.add(FetchAllCoins());
  }

  @override
  void dispose() {
    fetchAllCoinsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Currency List')),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: BlocBuilder<FetchAllCoinsBloc, FetchAllCoinsState>(
          bloc: fetchAllCoinsBloc,
          builder: (context, state) {
            if (state is FetchAllCoinsSuccess) {
              return CoinsList(coinsList: state.coins);
            } else if (state is FetchAllCoinsFailure) {
              return Center(child: Text('${state.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
