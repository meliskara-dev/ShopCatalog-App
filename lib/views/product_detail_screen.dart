import 'package:flutter/material.dart';
import 'package:mini_catalog_app/model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Data product;
  final Set<int> cardIds;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cardIds,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back", style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Hero(
                  tag: widget.product.id ?? 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.product.image ?? "",
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      widget.product.tagline ?? "",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(widget.product.description ?? ""),

                    SizedBox(height: 5),

                    Text(
                      widget.product.price ?? "N/A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.cardIds.add(widget.product.id ?? 0);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added to cart."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.grey.shade700,
                            margin: EdgeInsets.only(
                              bottom: 80,
                              left: 20,
                              right: 20,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text(
                        "Add to Card",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
