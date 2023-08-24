import 'package:hive/hive.dart';

part 'hive_class.g.dart';

@HiveType(typeId: 0)
class ProductDetails extends HiveObject {
  @HiveField(0)
  int ? poNo;

  @HiveField(1)
  DateTime? poDate;

  @HiveField(2)
  String? poDescription;

  @HiveField(3)
  List<Map<String, dynamic>> ? items;
}
