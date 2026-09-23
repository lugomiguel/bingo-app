import 'package:flutter/material.dart';

import '../constants/bingo_colors.dart';
import '../models/bingo_card.dart';

/// Formulario para digitar manualmente un cartón de bingo (5x5, 25 números).
class CardInputPage extends StatefulWidget {
  const CardInputPage({super.key, required this.siguienteId});

  final int siguienteId;

  @override
  State<CardInputPage> createState() => _CardInputPageState();
}

class _CardInputPageState extends State<CardInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();

  // controladores[fila][columna]
  late final List<List<TextEditingController>> _controladores =
      List.generate(
        5,
        (_) => List.generate(5, (_) => TextEditingController()),
      );

  @override
  void initState() {
    super.initState();
    _nombreController.text = 'Cartón ${widget.siguienteId}';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    for (final fila in _controladores) {
      for (final c in fila) {
        c.dispose();
      }
    }
    super.dispose();
  }

  String? _validarCelda(String? valor, int col) {
    if (valor == null || valor.trim().isEmpty) return 'Requerido';
    final n = int.tryParse(valor.trim());
    if (n == null) return 'Inválido';
    final min = rangoMinColumna(col);
    final max = rangoMaxColumna(col);
    if (n < min || n > max) return '$min-$max';
    return null;
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    final filas = List.generate(5, (fila) {
      return List.generate(5, (col) {
        if (BingoCard.esLibre(fila, col)) return null;
        return int.parse(_controladores[fila][col].text.trim());
      });
    });

    final numeros = filas.expand((f) => f).whereType<int>().toList();
    if (numeros.toSet().length != numeros.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hay números repetidos en el cartón'),
        ),
      );
      return;
    }

    final nombre = _nombreController.text.trim().isEmpty
        ? 'Cartón ${widget.siguienteId}'
        : _nombreController.text.trim();

    Navigator.of(context).pop(
      BingoCard(id: widget.siguienteId, nombre: nombre, filas: filas),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo cartón')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del cartón',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(5, (col) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: coloresLetrasBingo[col],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          letrasBingo[col],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Column(
                    children: List.generate(5, (fila) {
                      return Expanded(
                        child: Row(
                          children: List.generate(5, (col) {
                            if (BingoCard.esLibre(fila, col)) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withValues(
                                        alpha: 0.25,
                                      ),
                                      border: Border.all(
                                        color: Colors.amber,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '⭐',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: TextFormField(
                                  controller: _controladores[fila][col],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: coloresLetrasBingo[col]
                                        .withValues(alpha: 0.10),
                                    border: const OutlineInputBorder(),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  validator: (v) => _validarCelda(v, col),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _guardar,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar cartón'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
