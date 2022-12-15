import 'dart:io' as io;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:podliczator2000/model/summary_period.dart';

import '../model/summary.dart';

class PdfRaportService {
  Future<Uint8List> createRaport(List<Summary> soldProducts, List<String> days,
      SummaryPeriod period) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("fonts/AbhayaLibre-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final month = toBeginningOfSentenceCase(
        DateFormat.yMMMM('pl_PL').format(DateTime.parse(days[0])));

    pdf.addPage(pw.MultiPage(
        pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            theme: pw.ThemeData(
                defaultTextStyle: pw.TextStyle(font: ttf, fontSize: 16))),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Raport dla: Agata Sawicka"),
                      if (days[0] == days[1])
                        pw.Text("Okres: ${days[0]}")
                      else if (period == SummaryPeriod.monthly)
                        pw.Text("Okres: $month")
                      else
                        pw.Text("Okres: ${days[0]} - ${days[1]}"),
                      pw.Text(
                          "Wykonanych procedur: ${getSubTotalEntries(soldProducts)}"),
                      pw.Text(
                          "Suma: ${NumberFormat.currency(locale: 'pl_PL', symbol: 'zł').format(getSubTotalSum(soldProducts))}")
                    ])
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Text("Lp", textAlign: pw.TextAlign.center),
                      pw.Text("Nazwa procedury",
                          textAlign: pw.TextAlign.center),
                      pw.Text("Cena", textAlign: pw.TextAlign.center),
                      pw.Text("Ilość", textAlign: pw.TextAlign.center),
                      pw.Text("Suma", textAlign: pw.TextAlign.center),
                    ]),
                for (var i = 0; i < soldProducts.length; i++)
                  pw.TableRow(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text((soldProducts.indexOf(soldProducts[i]) + 1)
                              .toString()),
                        ]),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.SizedBox(
                              width: 250,
                              child: pw.Text(
                                soldProducts[i].procedureName,
                              )),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(soldProducts[i].procedureAmount.toString())
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(soldProducts[i].procedureEntries.toString())
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text((soldProducts[i].procedureAmount *
                                  soldProducts[i].procedureEntries)
                              .toStringAsFixed(2))
                        ]),
                  ]),
              ],
            )
          ];
        }));
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = io.File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }

  double getSubTotalSum(List<Summary> products) {
    return products.fold(
        0.0,
        (double prev, element) =>
            prev + (element.procedureAmount * element.procedureEntries));
  }

  String getSubTotalEntries(List<Summary> products) {
    return products
        .fold(0.0, (double prev, element) => prev + element.procedureEntries)
        .toStringAsFixed(0);
  }
}
