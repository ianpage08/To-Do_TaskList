import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/features/data/repositories/tarefa_controller.dart';
import 'package:estudo_flutter/toDoList/features/domain/services/ordenar_lista.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class AfazeresDomesticos extends StatefulWidget {
  const AfazeresDomesticos({super.key});

  @override
  State<AfazeresDomesticos> createState() => _AfazeresDomesticosState();
}

class _AfazeresDomesticosState extends State<AfazeresDomesticos> {
  final TarefaController _tarefaController = TarefaController(TarefasStorage());
  bool ordemCrescente = true;
  List<Tarefas> _listaAfazeres = List.from(
    NomeListas.nomeListas['afazeres domesticos'] ?? [],
  );
  void _carregarLista() async {
    try {
      final tarefas = await _tarefaController.carregar('afazeres domesticos');
      setState(() {
        _listaAfazeres.addAll(tarefas);
      });
    } catch (e) {
      Text('erro $e');
    }
  }

  void _ordenarLista() {
    ordemCrescente = !ordemCrescente;
    _listaAfazeres = OrdenarLista.ordenarLista(_listaAfazeres, ordemCrescente);
    setState(() {
      _listaAfazeres = [..._listaAfazeres];
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Pessoais', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _ordenarLista,
            icon: Icon(
              ordemCrescente
                  ? (Icons.arrow_upward_sharp)
                  : (Icons.arrow_downward_sharp),
            ),
            tooltip: 'Ordernar Tarefas',
            color: Colors.white,
          ),
        ],
      ),
      drawer: MenuDrawer(),
    );
  }
}
