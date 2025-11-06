import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

class NotesDialog extends StatelessWidget {
  String text;
  NotesDialog(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController notesController = TextEditingController()
      ..text = text;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(null);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                color: Colors.grey[100],
                child: TextField(
                  controller: notesController,
                  cursorColor: Theme.of(context).primaryColor,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: "*Type....",
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    //border: OutlineInputBorder(borderSide: BorderSide.none)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(notesController.text);
                      },
                      child: Text(
                        Strings.SUBMIT,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
