import 'package:flutter/material.dart';

import '../models/bingo_card.dart';
import '../widgets/tarjeta_carton.dart';
import 'card_input_page.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({
    super.key,
    required this.cartones,
    required this.marcados,
    required this.onAgregar,
  });

  final List<BingoCard> cartones;
  final Set<int> marcados;
  final ValueChanged<BingoCard> onAgregar;

  @override
  Widget build(BuildContext context) {
    final ordenados = [...cartones]
      ..sort((a, b) => b.aciertos(marcados).compareTo(a.aciertos(marcados)));
    final top3 = ordenados.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Cartones (${cartones.length})')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final nuevo = await Navigator.of(context).push<BingoCard>(
            MaterialPageRoute(
              builder: (_) =>
                  CardInputPage(siguienteId: cartones.length + 1),
            ),
          );
          if (nuevo != null) onAgregar(nuevo);
        },
        icon: const Icon(Icons.add),
        label: const Text('Cartón'),
      ),
      body: cartones.isEmpty
          ? const Center(
              child: Text(
                'Aún no hay cartones cargados.\nToca "Cartón" para agregar uno.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  if (top3.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Top 3 más cercanos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < top3.length; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: TarjetaCarton(
                                carton: top3[i],
                                marcados: marcados,
                                puesto: i + 1,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Divider(height: 32),
                  ],
                  const Text(
                    'Todos los cartones',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ordenados.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.82,
                    ),
                    itemBuilder: (context, i) => TarjetaCarton(
                      carton: ordenados[i],
                      marcados: marcados,
                    ),
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
    );
  }
}
