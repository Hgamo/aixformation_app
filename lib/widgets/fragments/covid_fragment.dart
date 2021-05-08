import 'package:aixformation_app/classes/vac_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rki_corona_api/rki_corona_api.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aachen = Provider.of<District>(context);
    final cases = Provider.of<CovidCases>(context);
    final vacData = Provider.of<VacData>(context);
    if (aachen == null || cases == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final int rowItmes =
        MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2;
    return ListView(
      children: [
        Text(
          'COVID-19-Dashboard',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Deutschland',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: rowItmes,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(10),
          children: [
            CovidGridTile(
              number: '+' + cases.difference.cases.toString(),
              barText: 'Neue Fälle',
            ),
            CovidGridTile(
              barText: 'Neue Todesfälle',
              number: '+' + cases.difference.deaths.toString(),
            ),
            CovidGridTile(
              barText: 'Totale Fälle',
              number: cases.cases.toString(),
            ),
            CovidGridTile(
              barText: 'Totale Todesfälle',
              number: cases.deaths.toString(),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Karte',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        Image.network('https://api.corona-zahlen.org/map/districts'),
        Text(
          'Städteregion Aachen',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: rowItmes,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(10),
          children: [
            CovidGridTile(
              number: aachen.weekIncidence.toStringAsFixed(0),
              barText: '7-Tage-Inzidenz',
            ),
            CovidGridTile(
              barText: 'Fälle pro 100.000 Einwohner',
              number: aachen.casesPer100K.toStringAsFixed(0),
            ),
            CovidGridTile(
              barText: 'Totale Fälle',
              number: aachen.count.toString(),
            ),
            CovidGridTile(
              barText: 'Totale Todesfälle',
              number: aachen.deaths.toString(),
            ),
          ],
        ),
        Text(
          'Impfungen',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: rowItmes,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.all(10),
          children: [
            CovidGridTile(
              number: (vacData.vaccinated / 1000000).toStringAsFixed(2),
              barText: 'Erstimpfungen (In Milionen)',
            ),
            CovidGridTile(
              barText: 'Quote',
              number: vacData.vaccinatedQuote.toStringAsFixed(2),
            ),
            CovidGridTile(
              barText: 'Zweitimpfung (In Milionen)',
              number: (vacData.secondVaccination / 1000000).toStringAsFixed(2),
            ),
            CovidGridTile(
              barText: 'Quote',
              number: vacData.secondVaccinationQuote.toStringAsFixed(2),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            'Robert Koch-Institut: COVID-19-Dashboard: Auswertungen basierend auf den aus den Gesundheitsämtern gemäß IfSG übermittelten Meldedaten',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            'Letzes Update: ' + cases.lastUpdate,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CovidGridTile extends StatelessWidget {
  final String barText;
  final String number;
  CovidGridTile({
    @required this.barText,
    @required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => launch('https://corona.rki.de'),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black26,
            title: Text(
              barText,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }
}
