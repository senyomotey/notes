import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, value, child) {
        return Slidable(
          key: ValueKey(note.uuid),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              appStateProvider.removeNote(uuid: note.uuid);
            }),
            children: [
              SlidableAction(
                onPressed: (context) {
                  appStateProvider.removeNote(uuid: note.uuid);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              value.note = note;
              value.readNote(context: context);
            },
            child: Card(
              color: value.getNoteColor(noteColor: NoteColor.values.firstWhere((e) => e.name == note.color)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0, left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy, hh:mm a').format(note.createdAt),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
