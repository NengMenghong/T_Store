// data/repositories/authentication/authentication_repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  User? get authUser => _auth.currentUser;

  get firebaseUser => null;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      if (googleAuth == null || googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Google authentication failed - missing tokens');
      }

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw Exception(TFirebaseAuthException(e.code).message);
    } on FirebaseException catch (e) {
      throw Exception(TFirebaseException(e.code).message);
    } on FormatException catch (_) {
      throw Exception(const TFormatException().message);
    } on PlatformException catch (e) {
      throw Exception(TPlatformException(e.code).message);
    } catch (e) {
      throw Exception('Something went wrong, Please try again');
    }
  }
}