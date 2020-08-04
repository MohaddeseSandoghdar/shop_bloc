import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_event.dart';
import 'package:shop_bloc_test/cart/bloc/cart_state.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_bloc.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_state.dart';
import 'package:shop_bloc_test/model/item_model.dart';

class MyCatalog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCatalogState();
}

class MyCatalogState extends State<MyCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () => Navigator.pushNamed(context, '/cart'))
          ],
        ),
        body: Container(child: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, state) {
            if (state is CatalogLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is CatalogLoaded)
              return ListView.builder(
                itemCount: state.catolog.length,
                itemBuilder: (BuildContext context, int index) {
                  return CatalogItem(state.catolog[index]);
                },
              );
            return Text('محصولی وجود ندارد.');
          },
        )));
  }
}

class CatalogItem extends StatefulWidget {
  final ItemModel catalogModel;
  CatalogItem(this.catalogModel);
  @override
  State<StatefulWidget> createState() => CatalogItemState();
}

class CatalogItemState extends State<CatalogItem> {
  TextEditingController countCtr = TextEditingController();
  CartBloc _cartBloc;
  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(40),
      color: widget.catalogModel.color,
      child: Column(
        children: <Widget>[
          Text(widget.catalogModel.name),
          SizedBox(height: 20),
          Text(widget.catalogModel.price.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 55,
                height: 55,
                child: OutlineButton(
                  onPressed: () {
                    _cartBloc.add(DecreaseItem(widget.catalogModel));
                  },
                  child: Icon(Icons.remove),
                ),
              ),
              Container(
                  width: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading)
                        return CircularProgressIndicator();
                      if (state is CartLoaded) {
                        var index = state.listReception
                            .indexWhere((x) => x.id == widget.catalogModel.id);
                        if (index >= 0) {
                          return Text(
                            '${state.listReception[index].count}',
                            textAlign: TextAlign.center,
                          );
                        } else
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                          );
                      }
                      return Text(
                        '0',
                        textAlign: TextAlign.center,
                      );
                    },
                  )),
              Container(
                width: 55,
                height: 55,
                child: OutlineButton(
                  onPressed: () {
                    _cartBloc.add(AddItem(widget.catalogModel));
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
          AddButton(widget.catalogModel)
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final ItemModel item;
  AddButton(this.item);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_basket),
      onPressed: () => BlocProvider.of<CartBloc>(context).add(AddItem(item)),
    );
  }
}
