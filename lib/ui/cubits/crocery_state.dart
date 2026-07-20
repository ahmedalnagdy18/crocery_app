part of 'crocery_cubit.dart';

@immutable
sealed class CroceryState {}

final class CroceryInitial extends CroceryState {}

final class CroceryLoaded extends CroceryState {
  final List<ItemModel> item;

  CroceryLoaded({required this.item});
}
