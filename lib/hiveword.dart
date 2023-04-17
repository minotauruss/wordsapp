import 'package:hive_flutter/hive_flutter.dart';

part 'hiveword.g.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */

@HiveType(typeId: 0)
class hiveword extends HiveObject {
  @HiveField(0)
  String date;
  @HiveField(1)
  String word;
  @HiveField(2)
  bool learn ;
  @HiveField(3)
  String turkish;

  hiveword({
    required this.word,
    required this.date,
    required this.learn,
    required this.turkish
    
    
  });
}
