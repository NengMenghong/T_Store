// features/shop/controllers/cart_controller.dart
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Map<productId, {product: ProductModel, qty: int}>
  var cartItems = <String, Map<String, dynamic>>{}.obs;

  /// Add (or increase) product
  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      final current = cartItems[product.id]!;
      cartItems[product.id] = {
        'product': current['product'] as ProductModel,
        'qty': (current['qty'] as int) + 1,
      }; // <-- reassign, triggers Obx
    } else {
      cartItems[product.id] = {'product': product, 'qty': 1};
    }
  }

  /// Increase by id
  void increaseQty(String productId) {
    final item = cartItems[productId];
    if (item == null) return;
    cartItems[productId] = {
      'product': item['product'] as ProductModel,
      'qty': (item['qty'] as int) + 1,
    };
  }

  /// Decrease by id (removes when 0)
  void decreaseQty(String productId) {
    final item = cartItems[productId];
    if (item == null) return;
    final q = item['qty'] as int;
    if (q > 1) {
      cartItems[productId] = {
        'product': item['product'] as ProductModel,
        'qty': q - 1,
      };
    } else {
      cartItems.remove(productId);
    }
  }

  int getQuantity(String productId) => cartItems[productId]?['qty'] ?? 0;
  bool isInCart(String productId) => cartItems.containsKey(productId);

  int get totalItems => cartItems.values.fold(0, (sum, item) => sum + (item['qty'] as int));

  double get totalCartPrice => cartItems.values.fold(0.0, (sum, item) {
    final p = item['product'] as ProductModel;
    final q = item['qty'] as int;
    return sum + (p.price * q);
  });

  List<Map<String, dynamic>> get items => cartItems.values.toList();

  void clearCart() => cartItems.clear();

  void removeFromCart(String productId) {}
}
