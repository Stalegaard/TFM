import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const ResultsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Agregar un poco de padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Resultados de las Imágenes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400, // Aumentar la altura del contenedor
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return Container(
                    width: MediaQuery.of(context).size.width, // Ajustar al ancho de la pantalla
                    margin: const EdgeInsets.symmetric(horizontal: 4.0), // Margen entre imágenes
                    child: Card(
                      elevation: 4, // Sombra del card
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.file(
                              result['image'], // Muestra la imagen
                              fit: BoxFit.cover, // Ajustar la imagen
                              height: 300, // Aumentar la altura de la imagen
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Porcentaje: ${result['percentage']}%',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
