import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_event.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_state.dart';
import 'package:shop_bloc_test/model/item_model.dart';


class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  @override
  get initialState => CatalogLoading();

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is GetCatalog) {
      yield CatalogLoading();
      try {
        Future.delayed(Duration(milliseconds: 500));
        yield CatalogLoaded(listItem);
      } catch (_) {
        yield CatalogError();
      }
    }
  }
}
