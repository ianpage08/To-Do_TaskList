import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/add_task.dart';
import 'package:flutter/material.dart';

class BtnAddTask extends StatefulWidget {
  final List<Tarefas> listaTarefas;

  const BtnAddTask({super.key, required this.listaTarefas});

  @override
  State<BtnAddTask> createState() => _BtnAddTaskState();
}

class _BtnAddTaskState extends State<BtnAddTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.11,
            height: MediaQuery.of(context).size.height * 0.05,
            child: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () async {
                final novaTarefa = await Navigator.push<Tarefas>(
                  context,
                  MaterialPageRoute(builder: (context) => Addtask()),
                );

                if (novaTarefa != null) {
                  setState(() {
                    widget.listaTarefas.add(novaTarefa);
                  });
                  
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
