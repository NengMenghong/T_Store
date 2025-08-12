// features/shop/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  var user = Rxn<AccessToken>();

  Future<void> loginWithFacebook() async {
    final result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
    if (result.status == LoginStatus.success) {
      user.value = result.accessToken;
      // Use the token to fetch user profile, authenticate your backend, etc.
    } else {
      Get.snackbar('Error', result.message ?? 'Unknown error');
    }
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    user.value = null;
  }
}
