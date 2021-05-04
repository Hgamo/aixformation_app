import 'package:flutter/material.dart';

class VacData {
  int vaccinated;
  double vaccinatedQuote;
  int secondVaccination;
  double secondVaccinationQuote;

  VacData({
    @required this.vaccinated,
    @required this.vaccinatedQuote,
    @required this.secondVaccination,
    @required this.secondVaccinationQuote,
  });
}
