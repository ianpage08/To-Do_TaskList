import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:flutter/material.dart';

class TaskConPen extends StatefulWidget {
  final List<Tarefas> titleList;

  const TaskConPen({super.key, required this.titleList});

  @override
  State<TaskConPen> createState() => _TaskConPenState();
}

class _TaskConPenState extends State<TaskConPen> {
  
    
  @override
  Widget build(BuildContext context) {
    
    final int tarefasConcluidas = widget.titleList.where((t) => t.done).length;
    final int tarefasPendentes = widget.titleList.where((t) => !t.done).length;
    
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),

      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Tarefas Concluídas: $tarefasConcluidas',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Tarefas Pendentes: $tarefasPendentes',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
