// To parse this JSON data, do
//
//     final stockDataModel = stockDataModelFromJson(jsonString);

import 'dart:convert';

StockModel stockDataModelFromJson(String str) => StockModel.fromJson(json.decode(str));

String stockDataModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  StockModel({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<StockListDataModel>? data;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<StockListDataModel>.from(json["data"].map((x) => StockListDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StockListDataModel {
  StockListDataModel({
    this.open,
    this.close,
    this.volume,
    this.symbol,
    this.exchange,
    this.date,
  });

  double? open;
  double? close;
  double? volume;
  String? symbol;
  String? exchange;
  DateTime? date;

  factory StockListDataModel.fromJson(Map<String, dynamic> json) => StockListDataModel(
        open: json["open"].toDouble(),
        close: json["close"].toDouble(),
        volume: json["volume"],
        symbol: json["symbol"],
        exchange: json["exchange"],
        date: json["date"]!=null?DateTime.parse(json["date"],):null,
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
        "volume": volume,
        "symbol": symbol,
        "exchange": exchange,
        "date": date,
      };
}

class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int? limit;
  int? offset;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "total": total,
      };
}
