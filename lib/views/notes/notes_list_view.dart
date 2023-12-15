import 'package:firstproject/services/crud/notes_service.dart';
import 'package:firstproject/utilities/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context: context);
              if (shouldDelete ?? false) {
                onDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete)
          ),
        );
      },
    );
  }
}
