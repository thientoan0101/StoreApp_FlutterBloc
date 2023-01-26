import 'package:store/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasEmptyCart = context.select<StoreBloc, bool>((b) => b.state.cartIds.isEmpty);
    final cartProducts = context.select<StoreBloc, List<Product>>(
        (b) => b.state.products.where((product) => b.state.cartIds.contains(product.id)).toList()
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: hasEmptyCart ?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your cart is empty'),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text('Add product')),
            ],
        ),
      )
      : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          return Card(
            key: ValueKey(product.id),
            child: Column(
              children: [
                Flexible(
                  child: Image.network(product.image),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                OutlinedButton(
                  onPressed: () => context.read<StoreBloc>().add(StoreProductsRemovedFromCart(product.id)),
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.all(2),
                    ),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.black12),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Remove from cart',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                )),
              ],
            ),
          );
        },
      )
    );
  }
}
