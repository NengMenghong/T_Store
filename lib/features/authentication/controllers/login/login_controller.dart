// features/authentication/controllers/login/login_controller.dart
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/utils/constraints/image_strings.dart';
import 'package:t_store/utils/helpers/loaders.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  /// --- Variables ---
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());

  @override
  void onInit() {
    /// Load saved credentials if Remember Me was checked before
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// --- Email & Password Sign In ---
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
        localStorage.remove('REMEMBER_ME_PASSWORD');
      }

      // Login with FirebaseAuth
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Redirect if login successful
      if (userCredential.user != null) {
        AuthenticationRepository.instance.screenRedirect();
      }
    } on FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Login Failed', message: e.message ?? 'Something went wrong');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// --- Google Sign In ---
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user data to Firestore
      await userController.saveUserRecord(userCredentials);

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Google Sign-In Failed', message: e.toString());
    }
  }

  /// --- Facebook Sign In ---
  Future<void> facebookSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        TFullScreenLoader.stopLoading();

        if (userCredential.user != null) {
          Get.snackbar(
            "Success",
            "Facebook sign-in successful",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.offAll(() => const HomeScreen());
        }
      } else if (result.status == LoginStatus.cancelled) {
        TFullScreenLoader.stopLoading();
        Get.snackbar(
          "Cancelled",
          "Facebook sign-in cancelled",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        TFullScreenLoader.stopLoading();
        Get.snackbar(
          "Failed",
          "Facebook sign-in failed: ${result.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Get.snackbar(
        "Error",
        "Facebook sign-in failed: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
