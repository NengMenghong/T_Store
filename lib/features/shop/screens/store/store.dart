// features/shop/screens/store/store.dart

import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String? selectedBrand;

  // Example product list (replace with your own product model if needed)
  final List<Map<String, dynamic>> allProducts = [
  {"title": "Bedroom Bed Black", "brand": "Furniture", "image": "assets/images/products/bedroom_bed_black.png", "price": 800, "sale": 720},
  {"title": "Bedroom Bed Grey", "brand": "Furniture", "image": "assets/images/products/bedroom_bed_grey.png", "price": 820, "sale": 750},
  {"title": "Bedroom Bed Simple Brown", "brand": "Furniture", "image": "assets/images/products/bedroom_bed_simple_brown.png", "price": 750, "sale": 680},
  {"title": "Bedroom Bed With Comforter", "brand": "Furniture", "image": "assets/images/products/bedroom_bed_with_comforter.png", "price": 950, "sale": 870},
  {"title": "Bedroom Sofa", "brand": "Furniture", "image": "assets/images/products/bedroom_sofa.png", "price": 600, "sale": 550},
  {"title": "Bedroom Bed", "brand": "Furniture", "image": "assets/images/products/bedroom_bed.png", "price": 700, "sale": 640},
  {"title": "Bedroom Wardrobe", "brand": "Furniture", "image": "assets/images/products/bedroom_wardrobe.png", "price": 1000, "sale": 900},
  {"title": "Bedroom Lamp", "brand": "Furniture", "image": "assets/images/products/bedroom_lamp.png", "price": 120, "sale": 100},
  {"title": "Office Chair 1", "brand": "Office", "image": "assets/images/products/office_chair_1.png", "price": 200, "sale": 180},
  {"title": "Office Chair 2", "brand": "Office", "image": "assets/images/products/office_chair_2.png", "price": 220, "sale": 200},
  {"title": "Office Desk 1", "brand": "Office", "image": "assets/images/products/office_desk_1.png", "price": 400, "sale": 360},
  {"title": "Office Desk 2", "brand": "Office", "image": "assets/images/products/office_desk_2.png", "price": 450, "sale": 400},
  {"title": "Kitchen Counter", "brand": "Kitchen", "image": "assets/images/products/kitchen_counter.png", "price": 500, "sale": 450},
  {"title": "Kitchen Dining Table", "brand": "Kitchen", "image": "assets/images/products/kitchen_dining table.png", "price": 600, "sale": 550},
  {"title": "Kitchen Refrigerator", "brand": "Kitchen", "image": "assets/images/products/kitchen_refrigerator.png", "price": 1200, "sale": 1100},
  {"title": "Tomi Dog Food", "brand": "Tomi", "image": "assets/images/products/tomi_dogfood.png", "price": 50, "sale": 45},
  {"title": "Samsung S9 Mobile", "brand": "Samsung", "image": "assets/images/products/samsung_s9_mobile.png", "price": 400, "sale": 360},
  {"title": "Acer Laptop 1", "brand": "Acer", "image": "assets/images/products/acer_laptop_1.png", "price": 700, "sale": 650},
  {"title": "Acer Laptop 2", "brand": "Acer", "image": "assets/images/products/acer_laptop_2.png", "price": 750, "sale": 700},
  {"title": "Acer Laptop 3", "brand": "Acer", "image": "assets/images/products/acer_laptop_3.png", "price": 800, "sale": 740},
  {"title": "Acer Laptop 4", "brand": "Acer", "image": "assets/images/products/acer_laptop_4.png", "price": 850, "sale": 780},
  {"title": "Acer Laptop Var 1", "brand": "Acer", "image": "assets/images/products/acer_laptop_var_1.png", "price": 700, "sale": 650},
  {"title": "Acer Laptop Var 2", "brand": "Acer", "image": "assets/images/products/acer_laptop_var_2.png", "price": 720, "sale": 670},
  {"title": "Acer Laptop Var 3", "brand": "Acer", "image": "assets/images/products/acer_laptop_var_3.png", "price": 740, "sale": 690},
  {"title": "Acer Laptop Var 4", "brand": "Acer", "image": "assets/images/products/acer_laptop_var_4.png", "price": 760, "sale": 710},
  {"title": "iPhone 12 Black", "brand": "Apple", "image": "assets/images/products/iphone_12_black.png", "price": 500, "sale": 450},
  {"title": "iPhone 13 Pro", "brand": "Apple", "image": "assets/images/products/iphone_13_pro.png", "price": 900, "sale": 850},
  {"title": "iPhone 14 White", "brand": "Apple", "image": "assets/images/products/iphone_14_white.png", "price": 1100, "sale": 1000},
  {"title": "iPhone 12 Blue", "brand": "Apple", "image": "assets/images/products/iphone_12_blue.png", "price": 520, "sale": 470},
  {"title": "iPhone 12 Red", "brand": "Apple", "image": "assets/images/products/iphone_12_red.png", "price": 530, "sale": 480},
  {"title": "iPhone 12 Green", "brand": "Apple", "image": "assets/images/products/iphone_12_green.png", "price": 540, "sale": 490},
  {"title": "iPhone 14 Pro", "brand": "Apple", "image": "assets/images/products/iphone_14_pro.png", "price": 1200, "sale": 1100},
  {"title": "iPhone 8 Back", "brand": "Apple", "image": "assets/images/products/iphone8_mobile_back.png", "price": 300, "sale": 270},
  {"title": "iPhone 8 Front", "brand": "Apple", "image": "assets/images/products/iphone8_mobile_front.png", "price": 300, "sale": 270},
  {"title": "iPhone 8 Dual Side", "brand": "Apple", "image": "assets/images/products/iphone8_mobile_dual_side.png", "price": 320, "sale": 280},
  {"title": "iPhone 8 Mobile", "brand": "Apple", "image": "assets/images/products/iphone8_mobile.png", "price": 310, "sale": 280},
  {"title": "iPhone 8 With Back", "brand": "Apple", "image": "assets/images/products/iphone8_mobile_back.png", "price": 310, "sale": 280},
  {"title": "Nike Shoes", "brand": "Nike", "image": "assets/images/products/nike-shoes.png", "price": 200, "sale": 180},
  {"title": "Leather Jacket 1", "brand": "Fashion", "image": "assets/images/products/leather_jacket_1.png", "price": 250, "sale": 220},
  {"title": "Leather Jacket 2", "brand": "Fashion", "image": "assets/images/products/leather_jacket_2.png", "price": 260, "sale": 230},
  {"title": "Leather Jacket 3", "brand": "Fashion", "image": "assets/images/products/leather_jacket_3.png", "price": 270, "sale": 240},
  {"title": "Leather Jacket 4", "brand": "Fashion", "image": "assets/images/products/leather_jacket_4.png", "price": 280, "sale": 250},
  {"title": "Tracksuit Black", "brand": "Nike", "image": "assets/images/products/tracksuit_black.png", "price": 150, "sale": 130},
  {"title": "Tracksuit Blue", "brand": "Nike", "image": "assets/images/products/tracksuit_blue.png", "price": 150, "sale": 130},
  {"title": "Tracksuit Red", "brand": "Nike", "image": "assets/images/products/tracksuit_red.png", "price": 150, "sale": 130},
  {"title": "Nike Air Jordan Black Red", "brand": "Nike", "image": "assets/images/products/NikeAirJOrdonBlackRed.png", "price": 250, "sale": 220},
  {"title": "Nike Air Jordan Orange", "brand": "Nike", "image": "assets/images/products/NikeAirJOrdonOrange.png", "price": 250, "sale": 220},
  {"title": "Nike Air Jordan White Magenta", "brand": "Nike", "image": "assets/images/products/NikeAirJordonwhiteMagenta.png", "price": 250, "sale": 220},
  {"title": "Nike Air Jordan White Red", "brand": "Nike", "image": "assets/images/products/NikeAirJOrdonWhiteRed.png", "price": 250, "sale": 220},
  {"title": "Nike Air Jordan Blue", "brand": "Nike", "image": "assets/images/products/NikeAirJordonSingleBlue.png", "price": 250, "sale": 220},
  {"title": "Nike Air Jordan Orange Single", "brand": "Nike", "image": "assets/images/products/NikeAirJordonSingleOrange.png", "price": 250, "sale": 220},
  {"title": "Nike Air Max", "brand": "Nike", "image": "assets/images/products/NikeAirMax.png", "price": 230, "sale": 200},
  {"title": "Nike Basketball Shoe Green Black", "brand": "Nike", "image": "assets/images/products/NikeBasketballShoeGreenBlack.png", "price": 240, "sale": 210},
  {"title": "Nike Wildhorse", "brand": "Nike", "image": "assets/images/products/NikeWildhorse.png", "price": 220, "sale": 190},
  {"title": "Tracksuit Parrot Green", "brand": "Nike", "image": "assets/images/products/trcksuit_parrotgreen.png", "price": 160, "sale": 140},
  {"title": "T-Shirt Blue Collar", "brand": "Fashion", "image": "assets/images/products/tshirt_blue_collar.png", "price": 50, "sale": 45},
  {"title": "T-Shirt Blue No Collar Back", "brand": "Fashion", "image": "assets/images/products/tshirt_blue_without_collar_back.png", "price": 50, "sale": 45},
  {"title": "T-Shirt Blue No Collar Front", "brand": "Fashion", "image": "assets/images/products/tshirt_blue_without_collar_front.png", "price": 50, "sale": 45},
  {"title": "T-Shirt Green Collar", "brand": "Fashion", "image": "assets/images/products/tshirt_green_collar.png", "price": 55, "sale": 50},
  {"title": "T-Shirt Red Collar", "brand": "Fashion", "image": "assets/images/products/tshirt_red_collar.png", "price": 55, "sale": 50},
  {"title": "T-Shirt Yellow Collar", "brand": "Fashion", "image": "assets/images/products/tshirt_yellow_collar.png", "price": 55, "sale": 50},
  {"title": "Product 1", "brand": "Fashion", "image": "assets/images/products/product-1.png", "price": 40, "sale": 35},
  {"title": "Product Jacket", "brand": "Fashion", "image": "assets/images/products/product-jacket.png", "price": 200, "sale": 180},
  {"title": "Product Jeans", "brand": "Fashion", "image": "assets/images/products/product-jeans.png", "price": 100, "sale": 90},
  {"title": "Product Shirt", "brand": "Fashion", "image": "assets/images/products/product-shirt.png", "price": 70, "sale": 60},
  {"title": "Product Shirt Blue 1", "brand": "Fashion", "image": "assets/images/products/product-shirt_blue_1.png", "price": 75, "sale": 65},
  {"title": "Product Shirt Blue 2", "brand": "Fashion", "image": "assets/images/products/product-shirt_blue_2.png", "price": 75, "sale": 65},
  {"title": "Product Slippers", "brand": "Fashion", "image": "assets/images/products/product-slippers.png", "price": 30, "sale": 25},
  {"title": "Slipper 1", "brand": "Fashion", "image": "assets/images/products/slipper-product-1.png", "price": 35, "sale": 30},
  {"title": "Slipper 2", "brand": "Fashion", "image": "assets/images/products/slipper-product-2.png", "price": 35, "sale": 30},
  {"title": "Slipper 3", "brand": "Fashion", "image": "assets/images/products/slipper-product-3.png", "price": 35, "sale": 30},
  {"title": "Slipper Product", "brand": "Fashion", "image": "assets/images/products/slipper-product.png", "price": 35, "sale": 30},
  {"title": "Adidas Football", "brand": "Adidas", "image": "assets/images/products/Adidas_Football.png", "price": 100, "sale": 90},
  {"title": "Baseball Bat", "brand": "Sports", "image": "assets/images/products/baseball_bat.png", "price": 80, "sale": 70},
  {"title": "Cricket Bat", "brand": "Sports", "image": "assets/images/products/cricket_bat.png", "price": 90, "sale": 80},
  {"title": "Tennis Racket", "brand": "Sports", "image": "assets/images/products/tennis_racket.png", "price": 120, "sale": 100},
];

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected brand
    final List<Map<String, dynamic>> filteredProducts = selectedBrand == null
        ? allProducts
        : allProducts.where((p) => p["brand"] == selectedBrand).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search in Store",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Featured Brands
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Featured Brands",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        setState(() => selectedBrand = null);
                      },
                      child: const Text("Clear Filter")),
                ],
              ),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _brandTile("Nike", "assets/images/products/nike-shoes.png"),
                    _brandTile("Adidas", "assets/images/products/Adidas_Football.png"),
                    _brandTile("Samsung", "assets/images/products/samsung_s9_mobile.png"),
                    _brandTile("Apple", "assets/images/products/iphone_12_black.png"),
                    _brandTile("IKEA", "assets/images/products/kitchen_dining table.png"),
                    _brandTile("Leather", "assets/images/products/leather_jacket_1.png"),
                    _brandTile("Pets", "assets/images/products/tomi_dogfood.png"),
                    _brandTile("Home Decor", "assets/images/products/bedroom_lamp.png"),
                    _brandTile("Office", "assets/images/products/office_chair_1.png"),
                    _brandTile("Kitchen", "assets/images/products/kitchen_refrigerator.png"),
                    _brandTile("Sports", "assets/images/products/Adidas_Football.png"),
                    _brandTile("Clothes", "assets/images/products/NikeAirJOrdonBlackRed.png"),
                    _brandTile("Electronics", "assets/images/products/acer_laptop_1.png"),
                    _brandTile("Furniture", "assets/images/products/kitchen_dining table.png"),
                    
                    
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Tabs (example with dummy)
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    const TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: "Furniture"),
                        Tab(text: "Electronics"),
                        Tab(text: "Clothes"),
                        Tab(text: "Sports"),

                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          
                          _brandSection("Furniture", [
                            "assets/images/products/bedroom_bed_black.png",
                            "assets/images/products/bedroom_bed_grey.png",
                            "assets/images/products/bedroom_bed_simple_brown.png",
                            "assets/images/products/bedroom_bed_with_comforter.png",
                            "assets/images/products/bedroom_sofa.png",
                            "assets/images/products/bedroom_bed.png",
                            "assets/images/products/bedroom_wardrobe.png",
                            "assets/images/products/bedroom_lamp.png",
                            "assets/images/products/office_chair_1.png",
                            "assets/images/products/office_chair_2.png",
                            "assets/images/products/office_desk_1.png",
                            "assets/images/products/office_desk_2.png",
                            "assets/images/products/kitchen_counter.png",
                            "assets/images/products/kitchen_dining table.png",
                            "assets/images/products/kitchen_refrigerator.png",
                            "assets/images/products/tomi_dogfood.png",

                          ]),
                          _brandSection("Electronics", [
                            "assets/images/products/samsung_s9_mobile.png",
                            "assets/images/products/acer_laptop_1.png",
                            "assets/images/products/acer_laptop_2.png",
                            "assets/images/products/acer_laptop_3.png",
                            "assets/images/products/acer_laptop_4.png",
                            "assets/images/products/acer_laptop_var_1.png",
                            "assets/images/products/acer_laptop_var_2.png",
                            "assets/images/products/acer_laptop_var_3.png",
                            "assets/images/products/acer_laptop_var_4.png",
                            "assets/images/products/iphone_12_black.png",
                            "assets/images/products/iphone_13_pro.png",
                            "assets/images/products/iphone_14_white.png",
                            "assets/images/products/iphone_12_blue.png",
                            "assets/images/products/iphone_12_red.png",
                            "assets/images/products/iphone_12_green.png",
                            "assets/images/products/iphone_14_pro.png",
                            "assets/images/products/iphone8_mobile_back.png",
                            "assets/images/products/iphone8_mobile_front.png",
                            "assets/images/products/iphone8_mobile_dual_side.png",
                            "assets/images/products/iphone8_mobile.png",
                            "assets/images/products/iphone8_mobile_back.png",
                            "assets/images/products/iphone8_mobile_back.png",
                            "assets/images/products/iphone8_mobile.png",
                          ]),
                          _brandSection("Clothes", [
                            "assets/images/products/nike-shoes.png",
                            "assets/images/products/leather_jacket_1.png",
                            "assets/images/products/leather_jacket_2.png",
                            "assets/images/products/leather_jacket_3.png",
                            "assets/images/products/leather_jacket_4.png",
                            "assets/images/products/tracksuit_black.png",
                            "assets/images/products/tracksuit_blue.png",
                            "assets/images/products/tracksuit_red.png",
                            "assets/images/products/NikeAirJOrdonBlackRed.png",
                            "assets/images/products/NikeAirJOrdonOrange.png",
                            "assets/images/products/NikeAirJordonwhiteMagenta.png",
                            "assets/images/products/NikeAirJOrdonWhiteRed.png",
                            "assets/images/products/NikeAirJordonSingleBlue.png",
                            "assets/images/products/NikeAirJordonSingleOrange.png",
                            "assets/images/products/NikeAirMax.png",
                            "assets/images/products/NikeBasketballShoeGreenBlack.png",
                            "assets/images/products/NikeWildhorse.png",
                            "assets/images/products/trcksuit_parrotgreen.png",
                            "assets/images/products/tracksuit_black.png",
                            "assets/images/products/tracksuit_blue.png",
                            "assets/images/products/tracksuit_red.png",
                            "assets/images/products/tshirt_blue_collar.png",
                            "assets/images/products/tshirt_blue_without_collar_back.png",
                            "assets/images/products/tshirt_blue_without_collar_front.png",
                            "assets/images/products/tshirt_green_collar.png",
                            "assets/images/products/tshirt_red_collar.png",
                            "assets/images/products/tshirt_yellow_collar.png",
                            "assets/images/products/product-1.png",
                            "assets/images/products/product-jacket.png",
                            "assets/images/products/product-jeans.png",
                            "assets/images/products/product-shirt.png",
                            "assets/images/products/product-shirt_blue_1.png",
                            "assets/images/products/product-shirt_blue_2.png",
                            "assets/images/products/product-slippers.png",
                            "assets/images/products/slipper-product-1.png",
                            "assets/images/products/slipper-product-2.png",
                            "assets/images/products/slipper-product-3.png",
                            "assets/images/products/slipper-product.png",

                          ]),
                          
                          _brandSection("Sports", [
                            "assets/images/products/Adidas_Football.png",
                            "assets/images/products/baseball_bat.png",
                            "assets/images/products/cricket_bat.png",
                            "assets/images/products/tennis_racket.png",
                          ]),
                         
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Products Section
              Text(
                selectedBrand == null
                    ? "All Products"
                    : "$selectedBrand Products",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 300,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, 
      mainAxisSpacing: 10, 
      crossAxisSpacing: 10, 
      childAspectRatio: 0.75, 
    ),
                  itemBuilder: (_, index) {
                    final product = filteredProducts[index];
                    return _productCard(
                      product["title"],
                      product["brand"],
                      product["image"],
                      product["price"].toDouble(),
                      product["sale"].toDouble(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Brand Tile with click
  Widget _brandTile(String name, String image) {
    final isSelected = selectedBrand == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBrand = name;
        });
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.red.shade100 : Colors.grey.shade200,
          border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 40),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  /// Product Card
  Widget _productCard(
      String title, String brand, String image, double price, double salePrice) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, height: 100, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(brand, style: TextStyle(color: Colors.grey.shade600)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$$salePrice",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                  Text("\$$price",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/// Brand Section with Products
  Widget _brandSection(String brandName, List<String> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(brandName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: Image.asset(images[index], width: 100),
              );
            },
          ),
        )
      ],
    );
  }