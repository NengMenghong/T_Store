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
  get selectedIndex => null;

  get screens => null;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      /// 🧪 Mock data for testing only
      final products = [
        ProductModel(
          id: '1',
          title: 'Test Shoes',
          price: 59.99,
          salePrice: 39.99,
          image: 'assets/images/products/acer_laptop_1.png',
          thumbnail:
              'assets/images/products/acer_laptop_1.png', // <-- set thumbnail
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
          thumbnail:
              'assets/images/products/iphone_12_blue.png', // <-- set thumbnail
          productType: ProductType.single.toString(),
          productVariations: [],
          stock: 5,
        ),
      ];

      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// get product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    //if no variations exist return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      //calculate the smallest and largest prices among variations
      if (product.productVariations != null) {
        for (var variation in product.productVariations!) {
          //determine the price to consider(sale price if available, otherwise regular price)
          double priceToConsider =
              variation.salePrice > 0.0 ? variation.salePrice : variation.price;

          //update smallest and largest price
          if (priceToConsider < smallestPrice) {
            smallestPrice = priceToConsider;
          }

          if (priceToConsider > largestPrice) {
            largestPrice = priceToConsider;
          }
        }
      } else {
        smallestPrice = 0.0;
        largestPrice = 234;
      }

      //if smallest and largest price are the same return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        //otherwise return A price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
