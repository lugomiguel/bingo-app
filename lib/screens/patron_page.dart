import 'package:flutter/material.dart';

import '../constants/bingo_colors.dart';
import '../models/bingo_card.dart';

/// Pestaña para editar la "forma" a completar: qué casillas de un cartón
/// 5x5 son obligatorias para dar el bingo por completado. Por defecto son
/// las 24 casillas con número (cartón completo); aquí se pueden desmarcar
/// las que no hagan falta para armar figuras (X, línea, marco, etc.).
/// Los cambios se aplican de inmediato, igual que en el tablero.
class PatronPage extends StatelessWidget {
  const PatronPage({
    super.key,
    required this.patron,
    required this.onToggle,
    required this.onRestablecer,
  });

  final Set<Celda> patron;
  final void Function(int fila, int col) onToggle;
  final VoidCallback onRestablecer;

  Future<void> _confirmarRestablecer(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restablecer forma'),
        content: const Text(
          '¿Restablecer a cartón completo? Se volverán a requerir las 24 '
          'casillas.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sí, restablecer'),
          ),
        ],
      ),
    );
    if (confirmado == true) onRestablecer();
  }

  void _alternar(BuildContext context, int fila, int col) {
    final celda = (fila, col);
    if (patron.length == 1 && patron.contains(celda)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe quedar al menos una casilla en la forma'),
        ),
      );
      return;
    }
    onToggle(fila, col);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forma a completar (${patron.length}/24)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Restablecer a cartón completo',
            onPressed: () => _confirmarRestablecer(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Toca las casillas que NO necesitas completar para dar el '
                'bingo por hecho. Lo que quede resaltado es la forma.',
                style: TextStyle(fontSize: 14),
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
                          final esLibre = BingoCard.esLibre(fila, col);
                          final requerida = patron.contains((fila, col));
                          final color = coloresLetrasBingo[col];
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: esLibre
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withValues(
                                          alpha: 0.25,
                                        ),
                                        border: Border.all(
                                          color: Colors.amber,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '⭐',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    )
                                  : Material(
                                      color: requerida
                                          ? color
                                          : color.withValues(alpha: 0.08),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        onTap: () =>
                                            _alternar(context, fila, col),
                                        child: Center(
                                          child: Icon(
                                            requerida
                                                ? Icons.check
                                                : Icons.close,
                                            color: requerida
                                                ? Colors.white
                                                : color.withValues(
                                                    alpha: 0.4,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
