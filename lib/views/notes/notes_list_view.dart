import 'package:firstproject/services/cloud/cloud_note.dart';
import 'package:firstproject/utilities/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTapNote;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTapNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            onTapNote(note);
          },
          trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context: context);
                if (shouldDelete ?? false) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete)),
        );
      },
    );
  }
}
