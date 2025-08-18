


class Tarefas {
  String title;
  bool done;
  String? prioridade;

  Tarefas({required this.title, this.done = false, this.prioridade});

  Map<String, dynamic> task() {
    return {'title': title, 'done': done, 'prioridade': prioridade};
  }
  factory Tarefas.fromMap(Map<String, dynamic> map) {
    return Tarefas(
      title: (map['title'] is String) ? map['title'] as String : '',
      done: (map['done'] is bool) ? map['done'] as bool : false,
      prioridade: (map['prioridade'] is String)
          ? map['prioridade'] as String
          : null,
    );
  }
}

