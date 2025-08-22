// features/shop/screens/product_details/product_detail.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store/utils/constraints/enums.dart';
import 'package:t_store/utils/constraints/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product, productId: '',),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1 - Product image slider
            TProductImageSlider(product: product),

            /// 2 - Product details
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Rating & Share button
                  const TRatingAndShare(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Price, Title, Stock & Brand
                  TProductMetaData(product: product),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Attributes (only for variable products)
                  if (product.productType == ProductType.variable.toString()) ...[
                    TProductAttributes(product: product),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],

                  /// Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                                          
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),



  /// Description
const TSectionHeading(
  title: 'Description',
  showActionButton: false,
),
const SizedBox(height: TSizes.spaceBtwItems),
ReadMoreText(
  product.description?.isNotEmpty == true
      ? product.description!
      : "This product is crafted with high-quality materials to deliver durability, comfort, and performance. Designed to meet your everyday needs, it combines modern style with reliable functionality — making it an essential addition to your lifestyle.",
  trimLines: 2,
  trimMode: TrimMode.Line,
  trimCollapsedText: '...Show more',
  trimExpandedText: ' Less',
  moreStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
  ),
  lessStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
  ),
),


                  /// Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews (199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreen()),
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
