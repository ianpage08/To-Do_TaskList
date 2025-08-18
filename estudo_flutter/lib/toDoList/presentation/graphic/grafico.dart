import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TaksGraphic extends StatelessWidget {
  final int totalTask;
  final int completeTask;
  final int pendingTask;

  const TaksGraphic({
    super.key,
    required this.totalTask,
    required this.completeTask,
    required this.pendingTask,
  });

  @override
  Widget build(BuildContext context) {
    if (totalTask == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nenhuma Tarefa Adicionada',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: _buildSections(),
          centerSpaceRadius: 50,
          sectionsSpace: 2,
          borderData: FlBorderData(show: false),
        ),
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  /// Função privada para gerar os dados do gráfico de pizza
  List<PieChartSectionData> _buildSections() {
    final double completePercentage = totalTask > 0
        ? (completeTask / totalTask) * 100
        : 0;
    final double pendingPercentage = totalTask > 0
        ? (pendingTask / totalTask) * 100
        : 0;

    return [
      PieChartSectionData(
        value: completeTask.toDouble(),
        color: Colors.green,
        title: '${completePercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: pendingTask.toDouble(),
        color: Colors.deepOrange,
        title: '${pendingPercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
