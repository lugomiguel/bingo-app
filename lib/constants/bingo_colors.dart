import 'package:flutter/material.dart';

const List<String> letrasBingo = ['B', 'I', 'N', 'G', 'O'];

const List<Color> coloresLetrasBingo = [
  Color(0xFFE53935), // B - rojo
  Color(0xFFFB8C00), // I - naranja
  Color(0xFF43A047), // N - verde
  Color(0xFF1E88E5), // G - azul
  Color(0xFF8E24AA), // O - morado
];

/// Rango válido de números para la columna [col] (0=B .. 4=O).
int rangoMinColumna(int col) => col * 15 + 1;
int rangoMaxColumna(int col) => col * 15 + 15;
