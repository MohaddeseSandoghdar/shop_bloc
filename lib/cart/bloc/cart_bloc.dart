import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_event.dart';
import 'package:shop_bloc_test/cart/bloc/cart_state.dart';
import 'package:shop_bloc_test/model/item_cart_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartLoading();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield CartLoading();
      try {
        yield CartLoaded(listReception: []);
      } catch (_) {
        yield CartError();
      }
    } else if (event is AddItem) {
      final currentState = state;
      if (currentState is CartLoaded) {
        // yield CartLoading();
        try {
          // await Future.delayed(Duration(seconds: 5));
          var index = currentState.listReception
              .indexWhere((x) => x.id == event.item.id);
          if (index < 0) {
            ItemCartModel itemCart = ItemCartModel(
                id: event.item.id,
                name: event.item.name,
                price: event.item.price,
                color: event.item.color,
                count: 1);

            yield CartLoaded(
              listReception: List.from(currentState.listReception)
                ..add(itemCart),
            );
          } else if (index >= 0) {
            currentState.listReception[index].count += 1;
            yield CartLoaded(listReception: currentState.listReception);
          }
        } catch (_) {
          yield CartError();
        }
      }
    } else if (event is DecreaseItem) {
      final currentState = state;
      if (currentState is CartLoaded) {
        // yield CartLoading();
        try {
          var index = currentState.listReception
              .indexWhere((item) => item.id == event.item.id);
          if (index < 0) {
            yield CartLoaded(listReception: currentState.listReception);
          } else {
            currentState.listReception[index].count -= 1;
            yield CartLoaded(listReception: currentState.listReception);
          }
        } catch (_) {
          yield CartError();
        }
      }
    }
  }
}
