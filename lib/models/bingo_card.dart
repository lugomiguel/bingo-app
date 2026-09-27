/// Posición (fila, columna) dentro de un cartón 5x5.
typedef Celda = (int fila, int col);

/// Un cartón de bingo de 5x5, cargado manualmente.
/// [filas] tiene 5 filas, cada una con 5 números (columnas B,I,N,G,O).
/// La celda central (fila 2, columna 2, 0-indexado) es el espacio "LIBRE":
/// no tiene número y no cuenta para los aciertos.
class BingoCard {
  BingoCard({required this.id, required this.nombre, required this.filas});

  final int id;
  final String nombre;
  final List<List<int?>> filas;

  static const filaLibre = 2;
  static const colLibre = 2;

  static bool esLibre(int fila, int col) =>
      fila == filaLibre && col == colLibre;

  /// Todas las celdas con número (24), usada como forma "cartón completo".
  static Set<Celda> patronCompleto() => {
    for (var fila = 0; fila < 5; fila++)
      for (var col = 0; col < 5; col++)
        if (!esLibre(fila, col)) (fila, col),
  };

  List<int> get numeros =>
      filas.expand((fila) => fila).whereType<int>().toList();

  /// Cuenta cuántas celdas requeridas por [patron] ya salieron en [marcados].
  int aciertos(Set<int> marcados, Set<Celda> patron) {
    var contador = 0;
    for (final (fila, col) in patron) {
      final numero = filas[fila][col];
      if (numero != null && marcados.contains(numero)) contador++;
    }
    return contador;
  }

  int totalCeldas(Set<Celda> patron) => patron.length;
}
