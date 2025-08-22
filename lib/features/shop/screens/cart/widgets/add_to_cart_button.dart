// features/shop/screens/cart/widgets/add_to_cart_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';

class AddToCartButton extends StatelessWidget {
  final String productId;

  const AddToCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() {
      final isInCart = cartController.isInCart(productId);

      return IconButton(
        icon: Icon(
          isInCart ? Iconsax.tick_circle : Iconsax.add,
          color: isInCart ? Colors.green : Colors.black,
        ),
        onPressed: () {
          if (isInCart) {
            cartController.removeFromCart(productId);
          } else {
            cartController.addToCart(productId as ProductModel);
          }
        },
      );
    });
  }
}
