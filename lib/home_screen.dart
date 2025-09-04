import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.setting_2, color: Color(0xFF1E2A51)),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Vize',
              style: TextStyle(
                color: Color(0xFF1E2A51),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Iconsax.eye,
              color: Colors.blue.shade800,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Color(0xFF1E2A51)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estado del salón',
                style: TextStyle(
                  color: Color(0xFF1E2A51),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const _TimeFilters(),
              const SizedBox(height: 24),
              const _ConsumptionChart(),
              const SizedBox(height: 24),
              const _QuickStatusModules(),
              const SizedBox(height: 24),
              const Text(
                'Estado en tiempo real',
                style: TextStyle(
                  color: Color(0xFF1E2A51),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const _RealTimeStatusList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeFilters extends StatelessWidget {
  const _TimeFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ChoiceChip(
          label: const Text('Diario'),
          selected: true,
          onSelected: (selected) {},
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF4A69FF),
          labelStyle: TextStyle(
            color: true ? Colors.white : const Color(0xFF1E2A51),
          ),
          avatar: const Icon(Iconsax.star, color: Colors.white),
        ),
        ChoiceChip(
          label: const Text('Mensual'),
          selected: false,
          onSelected: (selected) {},
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF4A69FF),
           labelStyle: TextStyle(
            color: false ? Colors.white : const Color(0xFF1E2A51),
          ),
           avatar: const Icon(Iconsax.star, color: Color(0xFF1E2A51)),
        ),
        ChoiceChip(
          label: const Text('Anual'),
          selected: false,
          onSelected: (selected) {},
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF4A69FF),
           labelStyle: TextStyle(
            color: false ? Colors.white : const Color(0xFF1E2A51),
          ),
           avatar: const Icon(Iconsax.star, color: Color(0xFF1E2A51)),
        ),
      ],
    );
  }
}

class _ConsumptionChart extends StatelessWidget {
  const _ConsumptionChart();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Consumo',
                  style: TextStyle(
                    color: Color(0xFF1E2A51),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(color: Color(0xFF4A69FF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 1000,
                  barTouchData: BarTouchData(enabled: false),
                   titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (double value, TitleMeta meta) {
                           const style = TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '2022';
                              break;
                            case 1:
                              text = '2013';
                              break;
                            case 2:
                              text = '2011';
                              break;
                            case 3:
                              text = '2021';
                              break;
                            case 4:
                              text = '2011';
                              break;
                             case 5:
                              text = '2021';
                              break;
                            default:
                              text = '';
                              break;
                          }
                           return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                         getTitlesWidget: (double value, TitleMeta meta) {
                          final style = TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                           String text;
                          if (value == 0) {
                            text = '0';
                          } else if (value == 100) {
                            text = '100';
                          } else if (value == 500) {
                            text = '500';
                          }
                          else if (value == 600) {
                            text = '600';
                          }
                          else if (value == 700) {
                            text = '700';
                          }else if (value == 1000) {
                            text = '1K';
                          }else {
                            return Container();
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(text, style: style),
                          );
                        },
                      ),
                    ),
                     topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBarGroup(0, 800, color: const Color(0xFF4A69FF)),
                    _buildBarGroup(1, 500, color: Colors.lightBlue),
                    _buildBarGroup(2, 600, color: Colors.lightBlue),
                    _buildBarGroup(3, 900, color: const Color(0xFF4A69FF)),
                    _buildBarGroup(4, 500, color: Colors.lightBlue),
                     _buildBarGroup(5, 600, color: Colors.lightBlue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, {Color color = Colors.blue}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 22,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}

class _QuickStatusModules extends StatelessWidget {
  const _QuickStatusModules();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatusCard(
          icon: Iconsax.flash_1,
          label: 'Iluminación',
        ),
        _StatusCard(
          icon: Iconsax.location,
          label: 'Movimiento',
        ),
        _StatusCard(
          icon: Iconsax.diagram,
          label: 'Consumo',
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2D3047),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _RealTimeStatusList extends StatelessWidget {
  const _RealTimeStatusList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _DeviceStatusTile(
          icon: Iconsax.arrow_down_2,
          deviceName: 'Luces',
          status: 'Encendido-Apagado',
        ),
        SizedBox(height: 12),
        _DeviceStatusTile(
          icon: Iconsax.arrow_up_1,
          deviceName: 'Aire acondicionado',
          status: 'Encendido-Apagado',
        ),
        SizedBox(height: 12),
        _DeviceStatusTile(
          icon: Iconsax.arrow_down_2,
          deviceName: 'Proyector',
          status: 'Encendido-Apagado',
        ),
      ],
    );
  }
}

class _DeviceStatusTile extends StatelessWidget {
  const _DeviceStatusTile({
    required this.icon,
    required this.deviceName,
    required this.status,
  });

  final IconData icon;
  final String deviceName;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, color: const Color(0xFF1E2A51)),
        ),
        title: Text(
          deviceName,
          style: const TextStyle(
            color: Color(0xFF1E2A51),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          status,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
