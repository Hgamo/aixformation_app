import 'dart:convert';

import 'package:aixformation_app/classes/vac_data.dart';
import 'package:http/http.dart' as http;

class VacHelper {
  static Future<VacData> getVacData() async {
    final response =
        await http.get(Uri.parse('https://api.corona-zahlen.org/vaccinations'));
    final data = jsonDecode(response.body) as Map;
    return VacData(
      vaccinated: data['data']['vaccinated'],
      vaccinatedQuote: data['data']['quote'],
      secondVaccination: data['data']['secondVaccination']
          ['vaccinated'],
      secondVaccinationQuote: data['data']['secondVaccination']
          ['quote'],
    );
  }
}
