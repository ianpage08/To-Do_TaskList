import 'package:estudo_flutter/toDoList/features/domain/services/prioridade.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/estudos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/afazeres_domesticos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/eventos_compromissos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/lista_de_compras.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/lista_de_desejos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/projetos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/tarefas_pessoais.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/trabalho.dart';
import 'package:flutter/material.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _Addtask();
}

class _Addtask extends State<Addtask> {
  final _controller = TextEditingController();

  String? _prioridadeSelected;
  final List<String> _nomeLista = NomeListas.nomeListas.keys.toList();
  String? _listaSelecionada = NomeListas.nomeListas.keys.first;
  void addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      NomeListas.addTaskInLista(
        _listaSelecionada!,
        Tarefas(
          title: _controller.text.trim(),
          prioridade: _prioridadeSelected ?? 'Baixa',
        ),
      );
      switch (_listaSelecionada) {
        case 'Tarefas Pessoal':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TarefasPessoais()),
          );
          break;
        case 'Lista de Compras':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaDeCompras()),
          );
          break;
        case 'Estudo':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Estudo()),
          );
          break;
        case 'lista de desejos':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListaDeDesejos()),
          );
          break;
        case 'Projetos':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Projetos()),
          );
          break;
        case 'Eventos e Compromissos':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventosCompromissos()),
          );
          break;
        case 'Trabalho':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Trabalho()),
          );
          break;
        case 'Afazeres Domesticos':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AfazeresDomesticos()),
          );
          break;
      }

      _controller.clear();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar - Tarefa')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Título da tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            PrioridadeTaks(
              initialValue: _prioridadeSelected,
              onChanged: (newValue) => {
                setState(() {
                  _prioridadeSelected = newValue;
                }),
              },
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DropdownButtonFormField(
                  value: _listaSelecionada,
                  items: _nomeLista.map((String nomeLista) {
                    return DropdownMenuItem<String>(
                      value: nomeLista,
                      child: Text(nomeLista),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _listaSelecionada = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(onPressed: addTask, child: Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
