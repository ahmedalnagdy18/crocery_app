import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hive_project/data/models/item_model.dart';
import 'package:hive_project/hive_registrar.g.dart';

class HiveHelper {
  static const String groceryBoxName = 'grocery_box';
  static late Box<ItemModel> groceryBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapters();

    groceryBox = await Hive.openBox<ItemModel>(groceryBoxName);
  }

  static List<ItemModel> getItems() {
    return groceryBox.values.toList();
  }

  static Future<List<ItemModel>> addItem(
    ItemModel item,
  ) async {
    await groceryBox.put(item.id, item);

    return getItems();
  }

  static Future<List<ItemModel>> updateItem(ItemModel item) async {
    item.isSelected = !item.isSelected;
    await groceryBox.put(item.id, item);
    return getItems();
  }

  static Future<List<ItemModel>> clearItems() async {
    await groceryBox.clear();
    return getItems();
  }
}
