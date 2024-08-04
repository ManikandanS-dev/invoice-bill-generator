import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/constant/kconst.dart';
import 'package:invoice/provider/cart_item/cart_item.dart';
import 'package:invoice/provider/printing/create_receipt_ptf.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class BillDetails extends ConsumerWidget {
  const BillDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    Future<dynamic> receiptePreview() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Preview'),
          content: SizedBox(
            height: 800,
            width: 450,
            child: PdfPreview(
              allowPrinting: false,
              canChangePageFormat: false,
              canChangeOrientation: false,
              build: (format) async => createReceiptPdf(
                cart,
                format,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Kconst.text4,
          border: Border.all(width: 1, color: Kconst.text2)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (var value in cart)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Kconst.text3,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  value.name,
                                  maxLines: 1,
                                )),
                                Icon(
                                  Icons.delete,
                                  color: Kconst.red2,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Kconst.red2,
                                ),
                                Text('${value.quantity}'),
                                Icon(
                                  Icons.add,
                                  color: Kconst.green2,
                                ),
                                Text('\$(${value.price * value.quantity})'),
                                Icon(
                                  Icons.mode_edit_outline,
                                  color: Kconst.text2,
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Kconst.red, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Payment Summary'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SubTotal'),
                        Text('\$800'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount'),
                        Text('-\$20'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('\$720'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Kconst.text,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        onPressed: () {
                          receiptePreview();
                        },
                        child: Text(
                          'Preview',
                          style: Kconst.kTextTheme(context).bodyLarge!.copyWith(
                              color: Kconst.text3, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Kconst.yellow2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: () {
                      ref.read(cartProvider.notifier).clearCart();
                    },
                    child: Text(
                      "Cancel",
                      style: Kconst.kTextTheme(context).bodyLarge!.copyWith(
                          color: Kconst.text3, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Kconst.green2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () async {
                        final List<Printer> printers =
                            await Printing.listPrinters();
                        final Printer targetPrinter = printers.firstWhere(
                          (printer) =>
                              printer.name == 'Microsoft PCL6 Class Driver',
                          orElse: () => const Printer(url: 'null'),
                        );
                        if (targetPrinter == const Printer(url: 'null')) {
                          await Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) async {
                              return await createReceiptPdf(
                                cart,
                                format,
                              );
                            },
                          );
                          ref.read(cartProvider.notifier).saveFireStore();
                        } else {
                          await Printing.directPrintPdf(
                            printer: targetPrinter,
                            onLayout: (format) async {
                              return await createReceiptPdf(
                                cart,
                                format,
                              );
                            },
                          );
                          ref.read(cartProvider.notifier).saveFireStore();
                        }
                      },
                      child: Text(
                        "Receipt",
                        softWrap: true,
                        maxLines: 1,
                        style: Kconst.kTextTheme(context).bodyLarge!.copyWith(
                            color: Kconst.text3, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
