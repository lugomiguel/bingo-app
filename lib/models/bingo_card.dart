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

  List<int> get numeros =>
      filas.expand((fila) => fila).whereType<int>().toList();

  int aciertos(Set<int> marcados) =>
      numeros.where(marcados.contains).length;

  int get totalCeldas => numeros.length;
}
