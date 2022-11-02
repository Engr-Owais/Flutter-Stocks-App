import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_tracker/repository/stock_repo.dart';
import 'package:stock_tracker/screen/stockReport.dart';
import 'bloc/cubit/stock_data_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitStocks(
        repository: RepoStock(),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MarketStockReport(),
      ),
    );
  }
}
