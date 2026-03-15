import 'package:flutter/material.dart';
import 'package:mini_catalog_app/views/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 350,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 5),

              Text(
                "to",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),

              SizedBox(height: 5),

              Text(
                "ShopCatalog",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade600,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),

      body: Column(
        children: [
          Center(
            child: Icon(
              Icons.shopping_bag,
              size: 100,
              color: Colors.orange,
              shadows: [
                BoxShadow(color: Colors.black12, offset: Offset(5, 15)),
              ],
            ),
          ),

          SizedBox(height: 80),

          Text(
            "Discover your favorite products...",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime,
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
