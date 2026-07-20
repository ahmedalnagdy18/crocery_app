import 'package:bloc/bloc.dart';
import 'package:hive_project/data/helper/hive_helper.dart';
import 'package:hive_project/data/models/item_model.dart';
import 'package:meta/meta.dart';

part 'crocery_state.dart';

class CroceryCubit extends Cubit<CroceryState> {
  CroceryCubit() : super(CroceryInitial());

  void getItems() {
    emit(CroceryLoaded(item: HiveHelper.getItems()));
  }

  Future<void> addItem(ItemModel item) async {
    final items = await HiveHelper.addItem(item);

    emit(CroceryLoaded(item: items));
  }

  Future<void> updateItem(ItemModel item) async {
    final items = await HiveHelper.updateItem(item);

    emit(CroceryLoaded(item: items));
  }

  Future<void> clearAllItem() async {
    final items = await HiveHelper.clearItems();

    emit(CroceryLoaded(item: items));
  }
}
