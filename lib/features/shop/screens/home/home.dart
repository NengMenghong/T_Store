// features/shop/screens/home/home.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/product_controller.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/utils/constraints/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// SEARCH BAR
                  
/// SEARCH BAR
Padding(
  padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  child: TextField(
    onChanged: (query) => controller.searchProducts(query),
    style: const TextStyle(color: Colors.white), // text color white
    decoration: InputDecoration(
      hintText: "Search in store...",
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: const Icon(Icons.search, color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),


                  /// POPULAR CATEGORIES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Popular Categories",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-bowling-50.png',
                                  label: 'Bowling'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-cosmetics-50.png',
                                  label: 'Cosmetics'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-dining-chair-side-vew-64.png',
                                  label: 'Dining Chair'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-dog-heart-64.png',
                                  label: 'Pets'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-shoes-50.png',
                                  label: 'Shoes'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-clothes-50.png',
                                  label: 'Clothes'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-school-uniform-62.png',
                                  label: 'Uniforms'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-smartphone-50.png',
                                  label: 'Smartphones'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-sparkling-diamond-50.png',
                                  label: 'Jewelry'),
                              _CategoryItem(
                                  icon: 'assets/icons/categories/icons8-toy-car-50.png',
                                  label: 'Toys'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
Column(
  children: [
    // Categories section
    SizedBox(height: 20),
    HomeBannerSlider(), // Our local image slider
    SizedBox(height: 20),
    // Popular products section
  ],
),


            /// POPULAR PRODUCTS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

  Obx(() {
  if (controller.isLoading.value) {
    return const TVerticalProductShimmer();
  }

  if (controller.searchResults.isEmpty) {
    return Center(
      child: Text(
        'No products found!',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  return TGridLayout(
    itemCount: controller.searchResults.length,
    itemBuilder: (_, index) => TProductCardVertical(
      product: controller.searchResults[index],
    ),
  );
}),

                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
class _CategoryItem extends StatelessWidget {
  final String icon;
  final String label;

  const _CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E5),
              shape: BoxShape.circle,
            ),
            child: Image.asset(icon, fit: BoxFit.contain),
          ),
          const SizedBox(height: 5),
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
