import 'package:hive_ce/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String icon;

  @HiveField(2)
  bool isSelected;

  @HiveField(3)
  late final String id;

  ItemModel({
    required this.name,
    required this.icon,
    this.isSelected = false,
    String? id,
  }) {
    this.id = id ?? DateTime.now().microsecondsSinceEpoch.toString();
  }
}
