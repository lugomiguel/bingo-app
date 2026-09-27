import '../models/bingo_card.dart';

/// Cartones precargados al abrir la app, para no tener que digitarlos
/// cada vez que recompilas durante el desarrollo.
///
/// Edita los números aquí para dejar cargados tus cartones reales.
/// Cada fila tiene 5 números (columnas B, I, N, G, O). La celda de
/// fila 2 / columna 2 (el centro) es el espacio libre: debe ser `null`.
///
/// Rango válido por columna: B 1-15, I 16-30, N 31-45, G 46-60, O 61-75.
final List<BingoCard> cartonesPredefinidos = [
  BingoCard(
    id: 1,
    nombre: 'Cartón 1375',
    filas: [
      [13, 23, 39, 50, 69],
      [1, 22, 34, 46, 64],
      [11, 29, null, 58, 75],
      [15, 20, 43, 59, 67],
      [9, 28, 31, 49, 71],
    ],
  ),
  BingoCard(
    id: 2,
    nombre: 'Cartón 3242',
    filas: [
      [14, 23, 39, 48, 72],
      [15, 28, 35, 57, 69],
      [6, 29, null, 46, 68],
      [11, 20, 33, 50, 62],
      [2, 17, 32, 51, 73],
    ],
  ),
  BingoCard(
    id: 3,
    nombre: 'Cartón 1373',
    filas: [
      [4, 27, 44, 59, 72],
      [8, 16, 38, 58, 63],
      [9, 20, null, 56, 65],
      [12, 28, 36, 60, 64],
      [11, 21, 45, 49, 66],
    ],
  ),
  BingoCard(
    id: 4,
    nombre: 'Cartón 1084',
    filas: [
      [5, 22, 38, 55, 66],
      [10, 29, 35, 54, 63],
      [14, 26, null, 52, 69],
      [12, 24, 31, 57, 73],
      [2, 20, 34, 56, 68],
    ],
  ),
  BingoCard(
    id: 5,
    nombre: 'Cartón 1083',
    filas: [
      [2, 22, 44, 46, 64],
      [5, 19, 34, 56, 67],
      [4, 24, null, 49, 72],
      [14, 28, 38, 54, 62],
      [9, 17, 32, 53, 61],
    ],
  ),
  BingoCard(
    id: 6,
    nombre: 'Cartón 1082',
    filas: [
      [14, 18, 36, 51, 72],
      [1, 25, 34, 54, 74],
      [9, 17, null, 49, 65],
      [4, 20, 35, 55, 62],
      [3, 21, 33, 52, 63],
    ],
  ),
  BingoCard(
    id: 7,
    nombre: 'Cartón 1040',
    filas: [
      [3, 18, 40, 48, 64],
      [8, 27, 41, 47, 63],
      [11, 23, null, 55, 69],
      [13, 21, 38, 56, 67],
      [15, 17, 42, 49, 66],
    ],
  ),
  BingoCard(
    id: 8,
    nombre: 'Cartón 1039',
    filas: [
      [5, 24, 45, 46, 74],
      [15, 30, 39, 47, 61],
      [14, 25, null, 53, 66],
      [6, 26, 33, 49, 75],
      [7, 27, 44, 57, 73],
    ],
  ),
  BingoCard(
    id: 9,
    nombre: 'Cartón 1038',
    filas: [
      [8, 25, 38, 55, 67],
      [14, 19, 35, 52, 65],
      [7, 28, null, 60, 61],
      [9, 17, 33, 59, 73],
      [13, 21, 36, 51, 70],
    ],
  ),
  BingoCard(
    id: 10,
    nombre: 'Cartón 402',
    filas: [
      [11, 17, 34, 49, 63],
      [2, 16, 38, 60, 67],
      [6, 28, null, 52, 66],
      [8, 22, 39, 56, 61],
      [10, 30, 37, 53, 64],
    ],
  ),
  BingoCard(
    id: 11,
    nombre: 'Cartón 1044',
    filas: [
      [15, 27, 38, 50, 68],
      [12, 22, 39, 57, 66],
      [9, 20, null, 60, 62],
      [8, 19, 33, 53, 71],
      [7, 30, 32, 58, 64],
    ],
  ),
  BingoCard(
    id: 12,
    nombre: 'Cartón 1043',
    filas: [
      [9, 21, 33, 50, 74],
      [1, 17, 31, 56, 70],
      [11, 24, null, 59, 62],
      [6, 18, 39, 49, 63],
      [10, 16, 41, 55, 65],
    ],
  ),BingoCard(
    id: 13,
    nombre: 'Cartón 1042',
    filas: [
      [15, 21, 45, 59, 63],
      [9, 16, 37, 48, 66],
      [13, 19, null, 56, 69],
      [5, 24, 42, 55, 65],
      [12, 23, 32, 54, 62],
    ],
  ),
  BingoCard(
    id: 14,
    nombre: 'Cartón 1041',
    filas: [
      [11, 17, 33, 60, 75],
      [10, 28, 40, 48, 73],
      [9, 30, null, 52, 72],
      [7, 29, 38, 51, 69],
      [5, 25, 42, 54, 63],
    ],
  ),
  BingoCard(
    id: 15,
    nombre: 'Cartón 408',
    filas: [
      [11, 16, 32, 49, 73],
      [3, 23, 36, 56, 65],
      [12, 26, null, 53, 68],
      [9, 19, 41, 59, 69],
      [2, 18, 40, 48, 62],
    ],
  ),
  BingoCard(
    id: 16,
    nombre: 'Cartón 407',
    filas: [
      [13, 27, 39, 47, 69],
      [9, 23, 45, 57, 75],
      [15, 24, null, 55, 64],
      [14, 25, 40, 59, 68],
      [8, 26, 38, 60, 74],
    ],
  ),
  BingoCard(
    id: 17,
    nombre: 'Cartón 406',
    filas: [
      [13, 22, 45, 50, 67],
      [1, 19, 37, 55, 65],
      [5, 24, null, 52, 75],
      [9, 30, 40, 47, 63],
      [11, 20, 31, 58, 73],
    ],
  ),
  BingoCard(
    id: 18,
    nombre: 'Cartón 405',
    filas: [
      [3, 27, 38, 52, 74],
      [2, 29, 43, 49, 68],
      [11, 30, null, 54, 65],
      [10, 28, 44, 51, 67],
      [8, 23, 33, 57, 66],
    ],
  ),
  BingoCard(
    id: 19,
    nombre: 'Cartón 404',
    filas: [
      [3, 29, 32, 48, 73],
      [12, 22, 39, 54, 74],
      [11, 16, null, 49, 66],
      [14, 23, 42, 47, 68],
      [15, 30, 33, 52, 61],
    ],
  ),
  BingoCard(
    id: 20,
    nombre: 'Cartón 403',
    filas: [
      [5, 24, 36, 48, 68],
      [10, 17, 31, 50, 74],
      [13, 23, null, 49, 72],
      [12, 30, 43, 55, 70],
      [3, 27, 40, 57, 64],
    ],
  ),
];
