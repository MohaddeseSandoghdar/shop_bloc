import 'package:equatable/equatable.dart';
import 'package:shop_bloc_test/model/item_cart_model.dart';
import 'package:shop_bloc_test/model/item_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartError extends CartState {}

class CartLoaded extends CartState {
  final List<ItemCartModel> listReception;
  CartLoaded({this.listReception});

  int get totalPrice =>
      listReception.fold(0, (total, current) => total + current.price);
  int get totalCount =>
      listReception.fold(0, (total, current) => total + current.count);
  @override
  List<Object> get props => [listReception];
}
