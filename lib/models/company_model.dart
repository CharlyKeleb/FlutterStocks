class CompanyData {
  String? name;
  String? symbol;
  bool? hasIntraday;
  bool? hasEod;
  Null? country;
  StockExchange? stockExchange;

  CompanyData(
      {this.name,
      this.symbol,
      this.hasIntraday,
      this.hasEod,
      this.country,
      this.stockExchange});

  CompanyData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    hasIntraday = json['has_intraday'];
    hasEod = json['has_eod'];
    country = json['country'];
    stockExchange = json['stock_exchange'] != null
        ? StockExchange.fromJson(json['stock_exchange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['has_intraday'] = this.hasIntraday;
    data['has_eod'] = this.hasEod;
    data['country'] = this.country;
    if (this.stockExchange != null) {
      data['stock_exchange'] = this.stockExchange!.toJson();
    }
    return data;
  }
}

class StockExchange {
  String? name;
  String? acronym;
  String? mic;
  String? country;
  String? countryCode;
  String? city;
  String? website;

  StockExchange(
      {this.name,
      this.acronym,
      this.mic,
      this.country,
      this.countryCode,
      this.city,
      this.website});

  StockExchange.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    acronym = json['acronym'];
    mic = json['mic'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['acronym'] = this.acronym;
    data['mic'] = this.mic;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['website'] = this.website;
    return data;
  }
}
