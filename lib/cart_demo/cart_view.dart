import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc/cart_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(CartLoadedEvent()),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart Demo"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.add_shopping_cart,
                        size: 38,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            state is CartLoaded
                                ? (state.cartList??[]).length.toString()
                                : "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            body: state is CartLoaded
                ? ListView.builder(
                    itemCount: (state.productList??[]).length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = (state.productList??[])[index];

                      return ListTile(
                        title: Text(item.title),
                        leading: const Icon(
                          Icons.apple,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(AddToCartEvent());
                          },
                          icon: item.isAdded
                              ? const Icon(
                                  Icons.shopping_cart,
                                )
                              : const Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
