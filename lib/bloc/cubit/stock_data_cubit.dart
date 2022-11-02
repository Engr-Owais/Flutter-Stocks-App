
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_tracker/repository/stock_repo.dart';
part 'stock_data_state.dart';

class CubitStocks extends Cubit<StateStocks> {
  CubitStocks({required this.repository}) : super(InitialLoading()) {
    getStockData();
  }

  final RepoStock repository;

  void getStockData() async {
    emit(Loading());
    try {
      var res = await repository.getStockData();
      if (res["data"] != null) {
        emit(GetStocksData(stockList: res["data"]));
      } else {
        emit(ErrorGet(error: res));
      }
    } catch (e) {
      emit(ErrorGet(error: e));
    }
  }
}
