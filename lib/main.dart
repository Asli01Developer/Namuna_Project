import 'package:flutter/material.dart';

void main() {
  runApp(const AppStateWidget(
    child: MaterialApp(debugShowCheckedModeBanner: false, title: "Store",),),);
}

class AppState {
  AppState({this.itemInCart = const <String>{}, required this.productList,});

  final List<String> productList;
  final Set<String> itemInCart;

  AppState copyWith({List<String>? productList, Set<String>? itemInCart,}) {
    return AppState(productList: productList ?? this.productList,
      itemInCart: itemInCart ?? this.itemInCart,);
  }
}

class AppStateScope extends InheritedWidget {
  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  const AppStateScope(this.data, {Key? key, required Widget child,})
      : super(key: key, child: child,);

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data == oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({super.key, required this.child});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState(productList: Server.)

  void setProductList(List<String> newProductList) {
    if (_data.productList != newProductList) {
      setState(() {
        _data = _data.copyWith(productList: newProductList);
      });
    }
  }

  void addToCart(String id) {
    if (!_data.itemInCart.contains(id)) {}
    setState(() {
      final Set<String> newItemCart = Set<String>.from(_data.itemInCart);
      newItemCart.add(id);
      _data = _data.copyWith(itemInCart: newItemCart);
    });
  }

  void removeFromCart(String id) {
    if (_data.itemInCart.contains(id)) {}
    setState(() {
      final Set<String> newItemCart = Set<String>.from(_data.itemInCart);
      newItemCart.remove(id);
      _data = _data.copyWith(itemInCart: newItemCart);
    });
  }


  @override
  Widget build(BuildContext context) {
    return AppStateScope(_data, child: widget.child);
  }
}

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  ProductListWidgetState createState() => ProductListWidgetState();
}

class ProductListWidgetState extends State<ProductListWidget> {
  List<String> get productList => _productList;
  List<String>  productList = Server.;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Set<String> itemsInCart = AppStateScope
        .of(context)
        .itemInCart;
    final bool hasPurchase = itemsInCart.isNotEmpty;

    return Stack(alignment: Alignment.center,
      children: [
        Padding(padding: EdgeInsets.only(right: hasPurchase
            ? 17.0
            : 10.0),
          child: const Icon(Icons.shopping_cart, color: Colors.black,),),
        if(hasPurchase)Padding(padding: const EdgeInsets.only(left: 17),
          child: CircleAvatar(radius: 8,
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            child: Text(itemsInCart.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        )

      ],);
  }
}

