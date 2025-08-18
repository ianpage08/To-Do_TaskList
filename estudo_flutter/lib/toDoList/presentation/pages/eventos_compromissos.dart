import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/features/data/repositories/tarefa_controller.dart';
import 'package:estudo_flutter/toDoList/features/domain/services/ordenar_lista.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class EventosCompromissos extends StatefulWidget {
  const EventosCompromissos({super.key});

  @override
  State<EventosCompromissos> createState() => _EventosCompromissosState();
}

class _EventosCompromissosState extends State<EventosCompromissos> {
  final TarefaController _tarefaController = TarefaController(TarefasStorage());
  bool ordemCrescente = true;
  List<Tarefas> _listaEventos = List.from(
    NomeListas.nomeListas['eventos e compromissos'] ?? [],
  );
  void _ordenarLista() {
    ordemCrescente = !ordemCrescente;
    _listaEventos = OrdenarLista.ordenarLista(_listaEventos, ordemCrescente);
    setState(() {
      _listaEventos = [..._listaEventos];
    });
  }
  void _carregarLista() async {
    try{
      final tarefas = await _tarefaController.carregar('eventos e compromissos');
      setState(() {
        _listaEventos = [...tarefas];
      });
    }catch(e){
      Text('Erro de execução $e');
    }
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
