import 'package:flutter/material.dart';

import '../constants/bingo_colors.dart';
import '../models/bingo_card.dart';
import '../widgets/tarjeta_carton.dart';

/// Tablero de números del bingo: 5 columnas (B-I-N-G-O) x 15 filas.
/// B: 1-15, I: 16-30, N: 31-45, G: 46-60, O: 61-75.
/// Al tocar un número se marca/desmarca como "cantado".
class NumberBoardPage extends StatelessWidget {
  const NumberBoardPage({
    super.key,
    required this.marcados,
    required this.cartones,
    required this.onToggle,
    required this.onReiniciar,
  });

  final Set<int> marcados;
  final List<BingoCard> cartones;
  final ValueChanged<int> onToggle;
  final VoidCallback onReiniciar;

  Future<void> _confirmarReinicio(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar tablero'),
        content: const Text(
          '¿Estás seguro de limpiar el tablero? Se borrarán todos los '
          'números marcados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sí, limpiar'),
          ),
        ],
      ),
    );
    if (confirmado == true) onReiniciar();
  }

  @override
  Widget build(BuildContext context) {
    final ordenados = [...cartones]
      ..sort((a, b) => b.aciertos(marcados).compareTo(a.aciertos(marcados)));
    final top3 = ordenados.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tablero de números (${marcados.length}/75)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reiniciar',
            onPressed: marcados.isEmpty
                ? null
                : () => _confirmarReinicio(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (top3.isNotEmpty) ...[
                SizedBox(
                  height: 108,
                  child: Row(
                    children: [
                      for (var i = 0; i < top3.length; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                            ),
                            child: TarjetaCarton(
                              carton: top3[i],
                              marcados: marcados,
                              puesto: i + 1,
                              compacto: true,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
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
                          fontSize: 26,
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
                  children: List.generate(15, (fila) {
                    return Expanded(
                      child: Row(
                        children: List.generate(5, (col) {
                          final numero = col * 15 + fila + 1;
                          final marcado = marcados.contains(numero);
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: _BotonNumero(
                                numero: numero,
                                marcado: marcado,
                                color: coloresLetrasBingo[col],
                                onTap: () => onToggle(numero),
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

class _BotonNumero extends StatelessWidget {
  const _BotonNumero({
    required this.numero,
    required this.marcado,
    required this.color,
    required this.onTap,
  });

  final int numero;
  final bool marcado;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: marcado ? color : color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Center(
          child: Text(
            '$numero',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: marcado ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}
