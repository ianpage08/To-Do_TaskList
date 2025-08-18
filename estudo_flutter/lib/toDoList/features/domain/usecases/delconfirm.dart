import 'package:flutter/material.dart';

class Delconfirm {
  static void showMostrardiaLog({
    required BuildContext context,
    required String title,
    required VoidCallback onDeleteConfirmed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Tarefa'),
          content: Text('Tem certeza que deseja excluir a tarefa "$title"?'),

          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => {Navigator.of(context).pop()},
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () => {
                onDeleteConfirmed(),
                Navigator.of(context).pop(),
              },
            ),
          ],
        );
      },
    );
  }
}
