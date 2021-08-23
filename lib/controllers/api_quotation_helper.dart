import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tc/models/quotation_model.dart';

class ApiQuotationHelper {
  // Singleton
  ApiQuotationHelper._();

  /// https://docs.awesomeapi.com.br/api-de-moedas
  static final ApiQuotationHelper instance = ApiQuotationHelper._();

  Future<List<QuotationModel>> getData(String url) async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<QuotationModel> data = [];
      result.forEach((key, value) {
        data.add(QuotationModel.fromMap(value));
      });

      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
