import 'package:equatable/equatable.dart';
import 'package:shop_bloc_test/model/item_model.dart';

abstract class CatalogState extends Equatable {
  @override
  List<Object> get props => [];
}

class CatalogLoading extends CatalogState {}

class CatalogError extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<ItemModel> catolog;
  CatalogLoaded(this.catolog);

  @override
  List<Object> get props => [catolog];

  @override
  String toString() => 'catologList: $catolog';
}
