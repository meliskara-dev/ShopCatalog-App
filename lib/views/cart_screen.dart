import 'package:flutter/material.dart';
import 'package:mini_catalog_app/model/product_model.dart';

class CartScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cardIds;
  const CartScreen({super.key, required this.products, required this.cardIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cardProducts = widget.products
        .where((product) => widget.cardIds.contains(product.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: cardProducts.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 180),
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 86,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Your cart is empty.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Add items to start shopping.",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cardProducts.length,
                        itemBuilder: (context, index) {
                          final item = cardProducts[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(item.image ?? ""),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(item.tagline ?? ""),
                                      Text(item.price ?? ""),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cardIds.remove(item.id);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red.shade500),

                    SizedBox(height: 8),
                    Text(
                      "  Hurry! Coupon expires in 45 minutes!",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Text("Checkout", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
