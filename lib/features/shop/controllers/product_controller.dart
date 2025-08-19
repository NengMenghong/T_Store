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
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  // inside ProductController


// Wishlist products
final RxList<ProductModel> wishlist = <ProductModel>[].obs;

/// Toggle favorite
void toggleFavorite(ProductModel product) {
  if (isInWishlist(product)) {
    wishlist.removeWhere((item) => item.id == product.id);
  } else {
    wishlist.add(product);
  }
}

/// Check if product is in wishlist
bool isInWishlist(ProductModel product) {
  return wishlist.any((item) => item.id == product.id);
}


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
    title: 'acer_laptop_1',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/acer_laptop_1.png',
    thumbnail: 'assets/images/products/acer_laptop_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '2',
    title: 'acer_laptop_2',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/acer_laptop_2.png',
    thumbnail: 'assets/images/products/acer_laptop_2.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '3',
    title: 'acer_laptop_3',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/acer_laptop_3.png',
    thumbnail: 'assets/images/products/acer_laptop_3.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '4',
    title: 'acer_laptop_4',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/acer_laptop_4.png',
    thumbnail: 'assets/images/products/acer_laptop_4.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '5',
    title: 'Adidas_Football',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/Adidas_Football.png',
    thumbnail: 'assets/images/products/Adidas_Football.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '6',
    title: 'bedroom_bed_back',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_bed_black.png',
    thumbnail: 'assets/images/products/bedroom_bed_black.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '7',
    title: 'bedroom_bed_grey',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_bed_grey.png',
    thumbnail: 'assets/images/products/bedroom_bed_grey.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '8',
    title: 'bedroom_bed_simple_brown',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_bed_simple_brown.png',
    thumbnail: 'assets/images/products/bedroom_bed_simple_brown.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '9',
    title: 'bedroom_bed_with_comforter',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_bed_with_comforter.png',
    thumbnail: 'assets/images/products/bedroom_bed_with_comforter.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '10',
    title: 'bedroom_bed',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_bed.png',
    thumbnail: 'assets/images/products/bedroom_bed.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '11',
    title: 'bedroom_lamp',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_lamp.png',
    thumbnail: 'assets/images/products/bedroom_lamp.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '12',
    title: 'bedroom_sofa',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_sofa.png',
    thumbnail: 'assets/images/products/bedroom_sofa.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '13',
    title: 'bedroom_wardrobe',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/bedroom_wardrobe.png',
    thumbnail: 'assets/images/products/bedroom_wardrobe.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '14',
    title: 'office_desk',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/office_desk_1.png',
    thumbnail: 'assets/images/products/office_desk_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '15',
    title: 'iphone_12_black',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_12_black.png',
    thumbnail: 'assets/images/products/iphone_12_black.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '16',
    title: 'iphone_12_blue',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_12_blue.png',
    thumbnail: 'assets/images/products/iphone_12_blue.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '17',
    title: 'iphone_12',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_12_green.png',
    thumbnail: 'assets/images/products/iphone_12_green.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '18',
    title: 'iphone_12_red',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_12_red.png',
    thumbnail: 'assets/images/products/iphone_12_red.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '19',
    title: 'iphone_13pro',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_13_pro.png',
    thumbnail: 'assets/images/products/iphone_13_pro.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '20',
    title: 'iphone_14pro',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_14_pro.png',
    thumbnail: 'assets/images/products/iphone_14_pro.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '21',
    title: 'iphone_14_white',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone_14_white.png',
    thumbnail: 'assets/images/products/iphone_14_white.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '22',
    title: 'iphone8_mobile_back',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone8_mobile_back.png',
    thumbnail: 'assets/images/products/iphone8_mobile_back.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '23',
    title: 'samsung_s9',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/samsung_s9_mobile.png',
    thumbnail: 'assets/images/products/samsung_s9_mobile.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '24',
    title: 'iphone8_mobile_front',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/iphone8_mobile_front.png',
    thumbnail: 'assets/images/products/iphone8_mobile_front.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '25',
    title: 'kitchen_dining_table',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/kitchen_dining table.png',
    thumbnail: 'assets/images/products/kitchen_dining table.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '26',
    title: 'leather_jacket',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/leather_jacket_1.png',
    thumbnail: 'assets/images/products/leather_jacket_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '27',
    title: 'leather_jacket_1',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/leather_jacket_1.png',
    thumbnail: 'assets/images/products/leather_jacket_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '28',
    title: 'leather_jacket_2',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/leather_jacket_2.png',
    thumbnail: 'assets/images/products/leather_jacket_2.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '29',
    title: 'leather_jacket_3',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/leather_jacket_3.png',
    thumbnail: 'assets/images/products/leather_jacket_3.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '30',
    title: 'leather_jacket_4',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/leather_jacket_4.png',
    thumbnail: 'assets/images/products/leather_jacket_4.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '31',
    title: 'nike_shoes',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/nike-shoes.png',
    thumbnail: 'assets/images/products/nike-shoes.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '32',
    title: 'NikeAirJordanBlackRed',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirJOrdonBlackRed.png',
    thumbnail: 'assets/images/products/NikeAirJOrdonBlackRed.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '33',
    title: 'NikeAirJordanOrange',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirJOrdonOrange.png',
    thumbnail: 'assets/images/products/NikeAirJOrdonOrange.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '34',
    title: 'NikeAirJordanSingleBlue',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirJordonSingleBlue.png',
    thumbnail: 'assets/images/products/NikeAirJordonSingleBlue.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '35',
    title: 'NikeAirJordanSingleOrange',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirJordonSingleOrange.png',
    thumbnail: 'assets/images/products/NikeAirJordonSingleOrange.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '36',
    title: 'NikeAirJordanWhiteRed',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirJOrdonWhiteRed.png',
    thumbnail: 'assets/images/products/NikeAirJOrdonWhiteRed.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '37',
    title: 'NikeAirMax',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeAirMax.png',
    thumbnail: 'assets/images/products/NikeAirMax.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '38',
    title: 'NikeMotivaShoesGreenBlack',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeBasketballShoeGreenBlack.png',
    thumbnail: 'assets/images/products/NikeBasketballShoeGreenBlack.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '39',
    title: 'NikeMotivaShoes',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/NikeWildhorse.png',
    thumbnail: 'assets/images/products/NikeWildhorse.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '40',
    title: 'office_chair_1',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/office_chair_1.png',
    thumbnail: 'assets/images/products/office_chair_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '41',
    title: 'office_chair_2',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/office_chair_2.png',
    thumbnail: 'assets/images/products/office_chair_2.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '42',
    title: 'office_desk_2',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/office_desk_2.png',
    thumbnail: 'assets/images/products/office_desk_2.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '43',
    title: 'office_desk_1',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/office_desk_1.png',
    thumbnail: 'assets/images/products/office_desk_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '44',
    title: 'product-jacket',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-jacket.png',
    thumbnail: 'assets/images/products/product-jacket.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '45',
    title: 'product-jeans',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-jeans.png',
    thumbnail: 'assets/images/products/product-jeans.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '46',
    title: 'product-shirt_blue_1',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-shirt_blue_1.png',
    thumbnail: 'assets/images/products/product-shirt_blue_1.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '47',
    title: 'product-shirt_blue_2',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-shirt_blue_2.png',
    thumbnail: 'assets/images/products/product-shirt_blue_2.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '48',
    title: 'product-shirt',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-shirt.png',
    thumbnail: 'assets/images/products/product-shirt.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  ProductModel(
    id: '49',
    title: 'product-slippers',
    price: 100.0,
    salePrice: 90.0,
    image: 'assets/images/products/product-slippers.png',
    thumbnail: 'assets/images/products/product-slippers.png',
    productType: ProductType.single.toString(),
    productVariations: [],
    stock: 5,
  ),
  
     
      ];

        featuredProducts.assignAll(products as Iterable<ProductModel>);
      searchResults.assignAll(products as Iterable<ProductModel>); // initialize search list
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔎 Search Products
  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(featuredProducts);
    } else {
      searchResults.assignAll(
        featuredProducts
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
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
