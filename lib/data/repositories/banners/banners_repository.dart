// data/repositories/banners/banners_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/banner_model.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  ///variables
  final _db = FirebaseFirestore.instance;

  ///get all orders related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners';
    }
  }



}
/*class BannerRepository extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      // -- Check this collection name! --
      final result = await _db.collection('Banners').get();
      
      // -- Print the result to the console for debugging! --
      print('Banners collection found: ${result.docs.isNotEmpty}'); 
      
      final banners = result.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      
      // -- Print the final list of banners! --
      print('Number of banners mapped: ${banners.length}');
      
      return banners;
      
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}*/