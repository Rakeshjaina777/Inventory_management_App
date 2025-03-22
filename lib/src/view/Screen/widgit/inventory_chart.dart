import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../controller/inventory_controller.dart dart Copy Edit.dart';

class InventoryChart extends StatelessWidget {
  final InventoryController controller;

  const InventoryChart({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BarChart(
        BarChartData(
          barGroups: controller.inventory.map((item) {
            return BarChartGroupData(
              x: controller.inventory.indexOf(item),
              barRods: [
                BarChartRodData(
                  toY: item.quantity.toDouble(),
                  color: item.quantity <= item.threshold
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  width: 16,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            );
          }).toList(),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
        ),
      ),
    );
  }
}
