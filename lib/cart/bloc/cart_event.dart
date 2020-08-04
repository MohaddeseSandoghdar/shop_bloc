import 'package:equatable/equatable.dart';
import 'package:shop_bloc_test/model/item_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class IncreaseItem extends CartEvent {
  final ItemModel item;
  IncreaseItem(this.item);
  @override
  List<Object> get props => [item];
}

class DecreaseItem extends CartEvent {
  final ItemModel item;
  DecreaseItem(this.item);

  @override
  List<Object> get props => [item];
}

class AddItem extends CartEvent {
  final ItemModel item;
  AddItem(this.item);

  @override
  List<Object> get props => [item];
}
