import 'package:flutter/material.dart';
import 'package:ahmed_wael_ecommerce_app/model/model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ahmed_wael_ecommerce_app/shopping_cart.dart';
import 'package:ahmed_wael_ecommerce_app/profile.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Model product;

  ProductDetailsScreen({required this.product});

  void _navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () => _navigateToProfileScreen(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.title}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      ' ${product.rating.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Images',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            CarouselSlider(
              options: CarouselOptions(
                height: 190,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
              ),
              items: product.images.map((imageUrl) {
                return Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Text(
              'Brand: ${product.brand}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'You Will Save: ${product.discountPercentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Description: ${product.description}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Add the product to the cart
                addToCart(product);

                // Show a snackbar to indicate that the product has been added to the cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart: ${product.title}'),
                  ),
                );
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                textStyle: TextStyle(color: Colors.black),
                fixedSize: Size(200, 50),
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Category: ${product.category}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Stock: ${product.stock}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
