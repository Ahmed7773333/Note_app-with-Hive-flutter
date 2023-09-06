import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subject;
  @HiveField(2)
  DateTime timeOnclock;
  @HiveField(3)
  String? amOrPm;
  @HiveField(4)
  String? time;

  Note({
    required this.title,
    required this.subject,
  }) : timeOnclock = DateTime.now() {
    amOrPm = timeOnclock.hour < 12 ? 'AM' : 'PM';
    time =
        '${(timeOnclock.month)}/${(timeOnclock.day)}/${(timeOnclock.year)}\n${(timeOnclock.hour)}:${(timeOnclock.minute)} ' +
            amOrPm!;
  }
}
