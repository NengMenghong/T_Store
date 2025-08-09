// features/shop/screens/home/widgets/promo_slider.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<String> bannerImages = [
    'assets/images/banners/banner_1.jpg',
    'assets/images/banners/banner_2.jpg',
    'assets/images/banners/banner_3.jpg',
    'assets/images/banners/banner_4.jpg',
    'assets/images/banners/banner_5.jpg',
    'assets/images/banners/banner_6.jpg',
    'assets/images/banners/banner_7.jpg',
    'assets/images/banners/banner_8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
      ),
      items: bannerImages.map((imagePath) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }
}
