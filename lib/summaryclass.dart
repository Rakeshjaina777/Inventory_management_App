import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const SummaryCard({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: GoogleFonts.poppins(color: Colors.white70)),
          SizedBox(height: 5),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}


class SummaryCards extends StatelessWidget {
  final int totalBicycles;
  final int totalItems;
  final String totalPrice;

  const SummaryCards({
    Key? key,
    required this.totalBicycles,
    required this.totalItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SummaryCard(title: 'Total Bicycles', value: '$totalBicycles'),
        SizedBox(
          width: 10,
        ),

        SummaryCard(title: 'Total Items', value: '$totalItems'),
        SizedBox(
          width: 10,
        ),
        SummaryCard(title: 'Total Price', value: totalPrice),
      ],
    );
  }
}
