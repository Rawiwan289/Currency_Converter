import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) =>
    ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
  bool? success;
  Request? request;
  Meta? meta;
  double? result;

  ExchangeRate({
    this.success,
    this.request,
    this.meta,
    this.result,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        success: json["success"],
        request:
            json["request"] == null ? null : Request.fromJson(json["request"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "request": request?.toJson(),
        "meta": meta?.toJson(),
        "result": result,
      };
}

class Meta {
  int? timestamp;
  Rates? rates;
  Formated? formated;

  Meta({
    this.timestamp,
    this.rates,
    this.formated,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        timestamp: json["timestamp"],
        rates: json["rates"] == null ? null : Rates.fromJson(json["rates"]),
        formated: json["formated"] == null
            ? null
            : Formated.fromJson(json["formated"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "rates": rates?.toJson(),
        "formated": formated?.toJson(),
      };
}

class Formated {
  String? from;
  String? to;

  Formated({
    this.from,
    this.to,
  });

  factory Formated.fromJson(Map<String, dynamic> json) => Formated(
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class Rates {
  double? from;
  double? to;

  Rates({
    this.from,
    this.to,
  });

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        from: json["from"]?.toDouble(),
        to: json["to"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class Request {
  String? from;
  String? to;
  int? amount;

  Request({
    this.from,
    this.to,
    this.amount,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "amount": amount,
      };
}
