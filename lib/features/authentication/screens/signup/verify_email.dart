// features/authentication/screens/signup/verify_email.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:t_store/routes/routes.dart';
import 'package:t_store/utils/constraints/image_strings.dart';
import 'package:t_store/utils/constraints/sizes.dart';
import 'package:t_store/utils/constraints/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({Key? key, this.email}) : super(key: key);

  static final authRepository = AuthenticationRepository.instance;
  final user = FirebaseAuth.instance.currentUser;

  final String? email;

  Future<void> checkEmailVerificationStatus() async {
    await authRepository.firebaseUser?.reload();
  }

  /*Future<void> _handleCheckEmailVerification(
      VerifyEmailController controller, BuildContext context) async {
    try {
      await Future.delayed(
          Duration(seconds: 2)); // give time to Firebase to update
      await FirebaseAuth.instance.currentUser?.reload();

      final isVerified = await controller.checkEmailVerificationStatus();
      print("Email verified: $isVerified"); // Debug line
      if (isVerified) {
        Get.offAllNamed(TRoutes.signupSuccess);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Email not verified yet. Please check your inbox.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Try again.')),
      );
    }
  }*/

  Future<void> _handleSendEmailVerification(
      VerifyEmailController controller, BuildContext context) async {
    try {
      await controller.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('An unexpected error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        //padding to give default equal space on all sides of screens
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///title & subtitle
              Text(TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final image = TImages.staticSuccessIllustration;
                    final title = "Account Created!";
                    final subTitle =
                        "Your account has been successfully created.";
                    Get.to(() => Scaffold(
                          body: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(TSizes.defaultSpace),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(image),
                                    width: THelperFunctions.screenWidth() * 0.6,
                                  ),
                                  const SizedBox(
                                      height: TSizes.spaceBtwSections),

                                  ///Title & Subtitle
                                  Text(title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      textAlign: TextAlign.center),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  Text(subTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      textAlign: TextAlign.center),
                                  const SizedBox(
                                      height: TSizes.spaceBtwSections),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.offAllNamed(TRoutes.signupSuccess);
                                      },
                                      child: const Text(TTexts.tContinue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () =>
                        _handleSendEmailVerification(controller, context),
                    child: const Text(TTexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
