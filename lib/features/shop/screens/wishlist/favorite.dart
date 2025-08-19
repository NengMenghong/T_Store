// features/shop/screens/wishlist/favorite.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/utils/constraints/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Obx(() {
        if (controller.wishlist.isEmpty) {
          return const Center(child: Text("No favorites yet!"));
        }
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TGridLayout(
            itemCount: controller.wishlist.length,
            itemBuilder: (_, index) =>
                TProductCardVertical(product: controller.wishlist[index]),
          ),
        );
      }),
    );
  }
}
