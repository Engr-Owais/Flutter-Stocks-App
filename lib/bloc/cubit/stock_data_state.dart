part of 'stock_data_cubit.dart';

class StateStocks extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialLoading extends StateStocks {}

class Loading extends StateStocks {}

class GetStocksData extends StateStocks {
dynamic stockList;

  GetStocksData({this.stockList});
@override
  List<Object?> get props => [stockList];
}

class ErrorGet extends StateStocks {
  var error;

  ErrorGet({this.error});
  @override
  List<Object?> get props => [error];
}