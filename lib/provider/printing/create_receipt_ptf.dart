import 'dart:async';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../model/cart_item.dart';

Future<Uint8List> createReceiptPdf(
    List<CartItem> cart, PdfPageFormat format) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.yrsaSemiBold();
  double subTotal = 0;

  for (var value in cart) {
    subTotal = value.price * value.quantity + subTotal;
  }
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'DATE        :  ${DateFormat.yMEd().add_jm().format(DateTime.now())}',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.Text(
              'CASHIER :',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              '=============================================',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Item',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  '                 QTY',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  'TOTAL PRICE',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Text(
              '----------------------------------------------------',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            ...cart.map(
              (e) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        e.name,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Row(
                        children: [
                          pw.Text(
                            e.quantity.toString(),
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                            ),
                          ),
                          pw.Spacer(),
                          pw.Text(
                            '${e.price * e.quantity}',
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            pw.Text(
              '----------------------------------------------------',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Sub Total  :',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Text(
                  subTotal.toString(),
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Discount   :',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Text(
                  '0.0',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Text(
              '=============================================',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Bill Total  :',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Text(
                  subTotal.toString(),
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Tendered  :',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Text(
                  '0.0',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Balance     :',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Text(
                  '0.0',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Text(
              '=============================================',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'THANK YOU',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            pw.Text(
              '=============================================',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
              ),
            ),
          ],
        ); // Center
      },
    ),
  );
  return pdf.save();
}

Future<void> listPrinters() async {
  print('Printer scaning');
  final List<Printer> printers = await Printing.listPrinters();
  for (final printer in printers) {
    print('Printer name: ${printer.name}');
  }
}
