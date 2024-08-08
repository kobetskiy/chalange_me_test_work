import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_work/model/coin_model.dart';
import 'package:test_work/service/http_service.dart';

part 'fetch_all_coins_event.dart';
part 'fetch_all_coins_state.dart';

class FetchAllCoinsBloc extends Bloc<FetchAllCoinsEvent, FetchAllCoinsState> {
  List<CoinModel> allCoins = [];

  FetchAllCoinsBloc() : super(FetchAllCoinsInitial()) {
    on<FetchAllCoins>((event, emit) async {
      try {
        emit(FetchAllCoinsLoading());
        final allCoins = await HttpService.getListCoins();
        emit(FetchAllCoinsSuccess(allCoins));
      } catch (e) {
        emit(FetchAllCoinsFailure(error: e));
      }
    });
  }
}
