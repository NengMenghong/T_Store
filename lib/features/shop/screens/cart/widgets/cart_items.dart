// features/shop/screens/cart/widgets/cart_items.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constraints/sizes.dart';

class TCartItems extends StatelessWidget {
  final bool showAddRemoveButtons;

  const TCartItems({Key? key, this.showAddRemoveButtons = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() {
  if (cartController.cartItems.isEmpty) {
    return const Center(child: Text("Your cart is empty"));
  }

  return ListView.separated(
    shrinkWrap: true,
    itemCount: cartController.cartItems.length,
    separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
    itemBuilder: (_, index) {
      final productId = cartController.cartItems.keys.elementAt(index);
      final item = cartController.cartItems[productId]!;
      final product = item['product'] as ProductModel;
      final qty = item['qty'] as int;

      return ListTile(
        leading: Image.network(
          product.thumbnail,   // ✅ your product image field
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.title),
        subtitle: Text("Quantity: $qty"),
        trailing: showAddRemoveButtons
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => cartController.removeFromCart(productId),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cartController.addToCart(product),
                  ),
                ],
              )
            : null,
      );
    },
  );
});

  }
}
