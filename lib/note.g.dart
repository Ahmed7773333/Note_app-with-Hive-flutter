// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// ***************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    return Note(
      title: reader.read(),
      subject: reader.read(),
    )
      ..timeOnclock = reader.read()
      ..amOrPm = reader.read()
      ..time = reader.read();
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..write(obj.title)
      ..write(obj.subject)
      ..write(obj.timeOnclock)
      ..write(obj.amOrPm)
      ..write(obj.time);
  }
}
