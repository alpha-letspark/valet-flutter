import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  late File file;
  ImageDialog(this.file, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0, top: 8.0),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
              ),
              Align(
                // These values are based on trial & error method
                alignment: const Alignment(1.05, -1.05),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(file);
                    },
                    child: const Text("Delete")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
