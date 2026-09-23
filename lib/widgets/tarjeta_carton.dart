import 'package:flutter/material.dart';

import '../constants/bingo_colors.dart';
import '../models/bingo_card.dart';

/// Tarjeta con la vista previa 5x5 de un cartón y su conteo de aciertos.
/// Si [puesto] no es nulo, se resalta como parte del Top 3 (oro/plata/bronce).
class TarjetaCarton extends StatelessWidget {
  const TarjetaCarton({
    super.key,
    required this.carton,
    required this.marcados,
    this.puesto,
    this.compacto = false,
  });

  final BingoCard carton;
  final Set<int> marcados;
  final int? puesto;

  /// Si es true, muestra solo nombre + barra de progreso (sin la
  /// cuadrícula 5x5), pensado para caber junto al tablero de números.
  final bool compacto;

  static const _coloresPuesto = [
    Color(0xFFFFD700), // oro
    Color(0xFFC0C0C0), // plata
    Color(0xFFCD7F32), // bronce
  ];

  @override
  Widget build(BuildContext context) {
    final aciertos = carton.aciertos(marcados);
    final esTop = puesto != null;

    if (compacto) {
      return Card(
        elevation: esTop ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: esTop
              ? BorderSide(color: _coloresPuesto[puesto! - 1], width: 2.5)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (esTop)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: _coloresPuesto[puesto! - 1],
                      ),
                    ),
                  Expanded(
                    child: Text(
                      carton.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '$aciertos/${carton.totalCeldas}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: aciertos / carton.totalCeldas,
                  minHeight: 8,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: esTop ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: esTop
            ? BorderSide(color: _coloresPuesto[puesto! - 1], width: 3)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (esTop)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.emoji_events,
                      size: 18,
                      color: _coloresPuesto[puesto! - 1],
                    ),
                  ),
                Expanded(
                  child: Text(
                    carton.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '$aciertos/${carton.totalCeldas}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Column(
              children: List.generate(5, (fila) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: Row(
                    children: List.generate(5, (col) {
                      final esLibre = BingoCard.esLibre(fila, col);
                      final numero = carton.filas[fila][col];
                      final marcado = esLibre || marcados.contains(numero);
                      final color = esLibre
                          ? Colors.amber
                          : coloresLetrasBingo[col];
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: marcado
                                    ? color
                                    : color.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    esLibre ? '⭐' : '$numero',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: esLibre ? 26 : 22,
                                      fontWeight: FontWeight.bold,
                                      color: marcado ? Colors.white : color,
                                    ),
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
          ],
        ),
      ),
    );
  }
}
