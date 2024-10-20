import 'dart:io';
import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  final List<File> files;
  final void Function(int) onRemove;

  const ImageSelector({super.key, required this.files, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: files.asMap().entries.map((entry) {
        int index = entry.key;
        File file = entry.value;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => onRemove(index), // Eliminar imagen al tocarla
            child: Stack(
              children: [
                Image.file(
                  file,
                  height: 100,
                ),
                const Positioned(
                  right: 0,
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
