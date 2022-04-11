// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/PagesGerente/avisoGerentePage.dart';
import 'package:flutter_application_1/Pages/PagesGerente/page_usuarios.dart';
import 'package:flutter_application_1/Pages/loginPage/loginPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class performancePage extends StatefulWidget {
  const performancePage({Key? key}) : super(key: key);

  @override
  State<performancePage> createState() => _performancePageState();
}

class _performancePageState extends State<performancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performances'),
        backgroundColor: const Color.fromARGB(255, 7, 69, 76),
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 0, child: Center(child: Text('SAIR')))
                  ]),
        ],
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text(
                  'UserName',
                ),
                accountEmail: Text('User.name@exemple.com'),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/vetores-gratis/astronauta-bonito-flying-with-rocket-cartoon-icon-illustration-pessoas-ciencia-icone-conceito-isolado-premium-estilo-cartoon-plana_138676-1534.jpg?w=740')),
              ),
              ListTile(
                leading: const Icon(Icons.add_chart),
                title: const Text('Performance'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_alert_outlined),
                title: const Text('Avisos'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const avisoGerentePage();
                  }));
                },
              ),
              const ListTile(
                leading: Icon(Icons.app_registration_outlined),
                title: Text('Tarefas'),
              ),
              ListTile(
                leading: const Icon(Icons.accessibility_outlined),
                title: const Text('Colaboradores'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const page_usuario();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: GraficoPerformance(),
      ),
    );
  }
}

onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const loginPage()));
      break;
    default:
  }
}

//--------------------------------------------------------------

class GraficoPerformance extends StatefulWidget {
  const GraficoPerformance({Key? key}) : super(key: key);

  @override
  State<GraficoPerformance> createState() => _GraficoPerformanceState();
}

class _GraficoPerformanceState extends State<GraficoPerformance> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCircularChart(
          title: ChartTitle(
            text: 'TAREFAS',
            textStyle: const TextStyle(fontSize: 30),
          ),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.concluidas,
              yValueMapper: (GDPData data, _) => data.totaTarefas,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true,
            ),
          ],
        ),
      ),
    ));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Concluidos', 5),
      GDPData('Pedentes', 3),
      GDPData('Em Andamento', 2),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(
    this.concluidas,
    this.totaTarefas,
  );

  String concluidas;
  int totaTarefas;
}
