// features/shop/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constraints/enums.dart';
import 'package:t_store/utils/helpers/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final productRepository = Get.put(ProductRepository());
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      /// 🧪 Mock data for testing
      final products = [
        ProductModel(
          id: '1',
          title: 'Test Shoes',
          price: 59.99,
          salePrice: 39.99,
          image: 'assets/images/products/acer_laptop_1.png',
          thumbnail: 'assets/images/products/acer_laptop_1.png',
          productType: ProductType.single.toString(),
          productVariations: [],
          stock: 10,
        ),
        ProductModel(
          id: '2',
          title: 'Smartphone',
          price: 699.99,
          salePrice: 599.99,
          image: 'assets/images/products/iphone_12_blue.png',
          thumbnail: 'assets/images/products/iphone_12_blue.png',
          productType: ProductType.single.toString(),
          productVariations: [],
          stock: 5,
        ),
        ProductModel(
          id: '3',
          title: 'Gaming Laptop',
          price: 1299.99,
          salePrice: 1199.99,
          image: 'assets/images/products/acer_laptop_1.png',
          thumbnail: 'assets/images/products/acer_laptop_1.png',
          productType: ProductType.single.toString(),
          productVariations: [],
          stock: 2,
        ),
      ];

      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get product price or range
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.toString()) {
      return "\$${(product.salePrice > 0 ? product.salePrice : product.price).toStringAsFixed(2)}";
    } else {
      if (product.productVariations != null && product.productVariations!.isNotEmpty) {
        for (var variation in product.productVariations!) {
          double priceToConsider =
              variation.salePrice > 0.0 ? variation.salePrice : variation.price;
          if (priceToConsider < smallestPrice) smallestPrice = priceToConsider;
          if (priceToConsider > largestPrice) largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return "\$${largestPrice.toStringAsFixed(2)}";
      } else {
        return "\$${smallestPrice.toStringAsFixed(2)} - \$${largestPrice.toStringAsFixed(2)}";
      }
    }
  }

  /// Calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// Check product stock
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
