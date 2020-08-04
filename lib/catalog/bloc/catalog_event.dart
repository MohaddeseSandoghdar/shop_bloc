import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable {}

class GetCatalog extends CatalogEvent {
  @override
  List<Object> get props => [];
}
