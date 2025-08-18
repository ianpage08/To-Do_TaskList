import 'package:flutter/material.dart';

class PrioridadeTaks extends StatefulWidget {
  // Adicione um parâmetro para o callback onChanged
  final ValueChanged<String?>? onChanged;
  final String? initialValue; // Opcional: para definir um valor inicial

  const PrioridadeTaks({
    super.key,
    this.onChanged, // O callback
    this.initialValue, // O valor inicial
  });

  @override
  State<PrioridadeTaks> createState() => _PrioridadeTaksState();
}

class _PrioridadeTaksState extends State<PrioridadeTaks> {
  final List<String> _prioridades = ['Baixa', 'Média', 'Alta'];
  String? _prioridadeSelecionada; // <-- Corrigido para usar esta variável de estado

  @override
  void initState() {
    super.initState();
    // Inicializa com o valor passado pelo pai (widget.initialValue) ou com o primeiro da lista
    _prioridadeSelecionada = widget.initialValue ?? _prioridades.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.85, // Ajuste a largura conforme necessário
        child: DropdownButtonFormField<String>(
          value: _prioridadeSelecionada, // <-- Usa a variável de estado correta
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Prioridade',
          ),
          items: _prioridades.map((String prioridade) {
            return DropdownMenuItem<String>(
              value: prioridade,
              child: Text(prioridade),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _prioridadeSelecionada = newValue; // <-- Atualiza a variável de estado correta
            });
            // Chama o callback passado pelo widget pai
            if (widget.onChanged != null) {
              widget.onChanged!(newValue); // <-- Corrigido de onChaged para onChanged
            }
          },
        ),
      ),
    );
  }
}