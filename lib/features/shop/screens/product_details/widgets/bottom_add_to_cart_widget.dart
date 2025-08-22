// features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/features/shop/controllers/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constraints/colors.dart';
import 'package:t_store/utils/constraints/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({
    super.key,
    required this.product, required String productId,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cart = CartController.instance;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(() {
        final inCart = cart.isInCart(product.id);
        final qty = cart.getQuantity(product.id);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (inCart)
              Row(
                children: [
                  TCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: TColors.grey,
                    color: TColors.white,
                    width: 40,
                    height: 40,
                    onPressed: () => cart.decreaseQty(product.id),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(
                    qty.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  TCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: TColors.black,
                    color: TColors.white,
                    width: 40,
                    height: 40,
                    onPressed: () => cart.increaseQty(product.id),
                  ),
                ],
              ),

            ElevatedButton(
              onPressed: () {
                if (inCart) {
                  // Go to checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to checkout...')),
                  );
                } else {
                  cart.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.title} added to cart!')),
                  );
                }
              },
              child: Text(inCart ? 'Checkout' : 'Add to Cart'),
            ),
          ],
        );
      }),
    );
  }
}
