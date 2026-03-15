import 'package:flutter/material.dart';
import 'package:mini_catalog_app/model/product_model.dart';
import 'package:mini_catalog_app/services/api_service.dart';
import 'package:mini_catalog_app/components/product_list_screen.dart';
import 'package:mini_catalog_app/views/product_detail_screen.dart';
import 'package:mini_catalog_app/views/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchBarController = TextEditingController();
  String searchQuery = "";
  bool isLoading = false;
  ApiService apiService = ApiService();
  List<Data> allProducts = [];
  String errorMessage = "";
  final Set<int> cardIds = {};

  @override
  void initState() {
    loadProducts();

    super.initState();
  }

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductModel resData = await apiService.fetchProduct();

      setState(() {
        allProducts = resData.data ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load products!";
      });
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((product) {
      final name = product.name ?? "";
      return name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back", style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: Colors.lime,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            products: allProducts,
                            cardIds: cardIds,
                          ),
                        ),
                      );
                    },
                    iconSize: 32,
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),

              SizedBox(height: 4),

              Text(
                "Find your favorite product.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(
                      Colors.orange.withOpacity(0.2),
                      BlendMode.lighten,
                    ),
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchBarController,
                  decoration: InputDecoration(
                    hintText: "Explore products",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 16),

              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage != "")
                Center(child: Text(errorMessage))
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                cardIds: cardIds,
                              ),
                            ),
                          );
                        },

                        child: ProductListScreen(product: product),
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
}
