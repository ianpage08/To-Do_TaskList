import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/estudos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/add_task.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/afazeres_domesticos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/eventos_compromissos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/lista_de_compras.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/lista_de_desejos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/projetos.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/tarefas_pessoais.dart';
import 'package:estudo_flutter/toDoList/presentation/pages/trabalho.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(5),
        children: [
          DrawerHeader(child: Text('Menu')),
          ListBody(
            children: [
              ListTile(
                title: Text('Adicionar tarefa'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => Addtask()),
                  ),
                },
              ),
              ListTile(
                title: Text('Tarefas Pessoais'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => TarefasPessoais()),
                  ),
                },
              ),
              ListTile(
                title: Text('Lista de Compras'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => ListaDeCompras()),
                  ),
                },
              ),
              ListTile(
                title: Text('Afazeres Domesticos'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AfazeresDomesticos(),
                    ),
                  ),
                },
              ),
              ListTile(
                title: Text('Lista de Desejos'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => ListaDeDesejos()),
                  ),
                },
              ),
              ListTile(
                title: Text('Estudo'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => Estudo()),
                  ),
                },
              ),
              ListTile(
                title: Text('Projetos'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => Projetos()),
                  ),
                },
              ),
              ListTile(
                title: Text('Eventos e Compromissos'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventosCompromissos(),
                    ),
                  ),
                },
              ),
              ListTile(
                title: Text('Trabalho'),
                onTap: () async => {
                  Navigator.push<Tarefas>(
                    context,
                    MaterialPageRoute(builder: (context) => Trabalho()),
                  ),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
