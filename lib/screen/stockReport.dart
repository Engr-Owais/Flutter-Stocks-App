import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stock_tracker/model/stock_model.dart';
import '../bloc/cubit/stock_data_cubit.dart';
import '../constants/app_utlis.dart';
import '../helper/internet_connectivity/internet_connectivity.dart';
import '../helper/internet_connectivity/no_internet_connection.dart';
import '../widgets/custom_appBar.dart';

class MarketStockReport extends StatefulWidget {
  const MarketStockReport({Key? key}) : super(key: key);

  @override
  State<MarketStockReport> createState() => _MarketStockReportState();
}

class _MarketStockReportState extends State<MarketStockReport> {
  final filterListController = TextEditingController();
  List<StockListDataModel> listStock = [];
  List<StockListDataModel> listSearch = [];
  List<DateTime> rangeDateList = [];

  late Map _source = {ConnectivityResult.mobile: true};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  DateTime? firstDate;
  DateTime? lastDate;

  void _showDatePicker() async {
    await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        lastDate: DateTime.now(),
        cancelButton: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: UtilHelper.appTextStyle(
                  color: UtilHelper.appColor, fontWeight: FontWeight.bold),
            )),
        calendarType: CalendarDatePicker2Type.range,
      ),
      dialogSize: const Size(325, 400),
      initialValue: [],
      borderRadius: BorderRadius.circular(15),
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        firstDate =
            DateTime.utc(value[0]!.year, value[0]!.month, value[0]!.day);
        lastDate = DateTime.utc(value[1]!.year, value[1]!.month, value[1]!.day);

        var list = listStock
            .where((element) =>
                element.date!.difference(firstDate!).inDays >= 0 &&
                element.date!.difference(lastDate!).inDays <= 0)
            .toList();
        listStock = list;

        setState(() {});
      } else {}
    });
  }

  void _onSearchTextChanged(String text) {
    listSearch.clear();
    if (text.isEmpty) {
      setState(() {
        return;
      });
    }

    for (var element in listStock) {
      if (element.symbol!.toLowerCase().contains(text.toLowerCase()) ||
          element.exchange!.toLowerCase().contains(text.toLowerCase()) ||
          element.open!.toString().toLowerCase().contains(text.toLowerCase()) ||
          element.close!
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          element.volume!
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase())) {
        listSearch.add(element);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) setState(() => _source = source);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool connectionStatus = UtilHelper.getInternetConnection(_source);
    if (!connectionStatus) {
      return InternetOff();
    } else {
      return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: BlocConsumer<CubitStocks, StateStocks>(
                listener: (context, state) {
              if (state is GetStocksData) {
                for (int i = 0; i < 10; i++) {
                  StockListDataModel stocks =
                      StockListDataModel.fromJson(state.stockList[i]);
                  listStock.add(stocks);
                }
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UtilHelper.mainHeadingTextWidget(text: 'STOCKS DATA'),
                      ],
                    ),
                  ),
                  CustomAppBar(
                    filterListController: filterListController,
                    onSearchTextChanged: _onSearchTextChanged,
                  ),
                  _stockTrackerList(state),
                ],
              );
            })),
      );
    }
  }

  _stockTrackerList(StateStocks state) {
    return Expanded(
      child: state is Loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ErrorGet is ErrorGet
              ? const Center(
                  child: Text("Limit exceed"),
                )
              : filterListController.text.isNotEmpty && listSearch.isEmpty
                  ? const Center(
                      child: Text("No result found..."),
                    )
                  : listStock.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: filterListController.text.isNotEmpty ||
                                  listSearch.isNotEmpty
                              ? listSearch.length
                              : listStock.length,
                          itemBuilder: (context, index) {
                            return _buildStockWidget(index);
                          })
                      : const Center(
                          child: Text("No List Found"),
                        ),
    );
  }

  _buildStockWidget(int index) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: _stockTitleDetails(index),
            ),
            UtilHelper.sizedBox(width: 5.0),
            Expanded(
              flex: 2,
              child: _stockPriceDetails(index),
            ),
          ],
        ));
  }

  _stockTitleDetails(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UtilHelper.mainHeadingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? listSearch[index].symbol!
                    : listStock[index].symbol!),
            UtilHelper.sizedBox(height: 5.0),
            UtilHelper.headingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? listSearch[index].exchange!
                    : listStock[index].exchange!),
            UtilHelper.sizedBox(height: 5.0),
            UtilHelper.headingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? _convertIntoDateFormat(listStock[index].date!)
                    : _convertIntoDateFormat(listStock[index].date!)),
          ],
        ))
      ],
    );
  }

  _stockPriceDetails(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UtilHelper.headingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? listSearch[index].open!.toString()
                    : listStock[index].open!.toString()),
            UtilHelper.sizedBox(height: 5.0),
            UtilHelper.headingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? listSearch[index].close!.toString()
                    : listStock[index].close!.toString()),
            UtilHelper.sizedBox(height: 5.0),
            UtilHelper.headingTextWidget(
                text: filterListController.text.isNotEmpty ||
                        listSearch.isNotEmpty
                    ? listSearch[index].volume!.toString()
                    : listStock[index].volume.toString()),
          ],
        ))
      ],
    );
  }

  String _convertIntoDateFormat(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String string = dateFormat.format(dateTime.toLocal());
    return string;
  }
}
