import 'package:flutter/material.dart';

import '../data/cartones_predefinidos.dart';
import '../models/bingo_card.dart';
import 'cards_page.dart';
import 'number_board_page.dart';
import 'patron_page.dart';

/// Contenedor raíz: guarda los números marcados y los cartones cargados,
/// y los comparte entre el tablero y el módulo de cartones.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tabActual = 0;
  final Set<int> _marcados = {};
  final List<BingoCard> _cartones = List.of(cartonesPredefinidos);
  Set<Celda> _patron = BingoCard.patronCompleto();

  @override
  Widget build(BuildContext context) {
    final paginas = [
      PatronPage(
        patron: _patron,
        onToggle: (fila, col) => setState(() {
          final celda = (fila, col);
          if (_patron.contains(celda)) {
            _patron = {..._patron}..remove(celda);
          } else {
            _patron = {..._patron}..add(celda);
          }
        }),
        onRestablecer: () =>
            setState(() => _patron = BingoCard.patronCompleto()),
      ),
      NumberBoardPage(
        marcados: _marcados,
        cartones: _cartones,
        patron: _patron,
        onToggle: (numero) => setState(() {
          if (!_marcados.remove(numero)) _marcados.add(numero);
        }),
        onReiniciar: () => setState(_marcados.clear),
      ),
      CardsPage(
        cartones: _cartones,
        marcados: _marcados,
        patron: _patron,
        onAgregar: (carton) => setState(() => _cartones.add(carton)),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _tabActual, children: paginas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabActual,
        onDestinationSelected: (i) => setState(() => _tabActual = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            label: 'Forma',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_on),
            label: 'Tablero',
          ),
          NavigationDestination(
            icon: Icon(Icons.style),
            label: 'Cartones',
          ),
        ],
      ),
    );
  }
}
