import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/note.dart';

class NoteTile extends StatelessWidget {
  Note note;

  NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(note.id),
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: Card(
        color: null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 35.0, bottom: 40.0, right: 20.0, left: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                note.title,
                maxLines: 4,
                textAlign: TextAlign.left,
                style: GoogleFonts.getFont(
                  'Nunito',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                note.createdAt,
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Nunito',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
