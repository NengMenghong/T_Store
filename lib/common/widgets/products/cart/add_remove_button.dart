// common/widgets/products/cart/add_remove_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constraints/colors.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  final ProductModel product;

  const TProductQuantityWithAddRemoveButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return Obx(() {
      final qty = cart.cartItems[product.id]?['qty'] ?? 0;

      if (qty > 0) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: TColors.primary),
              onPressed: () => cart.removeFromCart(product.id),
            ),
            Text(
              qty.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add, color: TColors.primary),
              onPressed: () => cart.addToCart(product),
            ),
          ],
        );
      } else {
        return IconButton(
          icon: const Icon(Iconsax.add, color: TColors.primary),
          onPressed: () => cart.addToCart(product),
        );
      }
    });
  }
}
