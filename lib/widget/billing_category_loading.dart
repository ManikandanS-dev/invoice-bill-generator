import 'package:flutter/material.dart';
import 'package:invoice/constant/kconst.dart';
import 'package:shimmer/shimmer.dart';

class BillingCategoryLoading extends StatelessWidget {
  const BillingCategoryLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Kconst.backround,
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            direction: ShimmerDirection.ltr,
            baseColor: Kconst.text4,
            highlightColor: Kconst.text2,
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
              child: Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
