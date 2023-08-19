import 'package:flutter/material.dart';
import 'package:ahmed_wael_ecommerce_app/model/model.dart';
import 'package:ahmed_wael_ecommerce_app/profile.dart';

List<Model> cachedProducts = []; // List to store cached products

void addToCart(Model product) {
  // Check if the product is already in the cart
  int existingIndex = cachedProducts.indexWhere((p) => p.id == product.id);
  if (existingIndex != -1) {
    // Product is already in the cart, increase its quantity
    cachedProducts[existingIndex].quantity++;
  } else {
    // Product is not in the cart, add it with quantity 1
    product.quantity = 1;
    cachedProducts.add(product);
  }
}

void removeFromCart(Model product) {
  cachedProducts.remove(product); // Remove the product from the cart
}

void clearCachedProducts() {
  cachedProducts.clear();
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  double calculateTotalPrice() {
    double totalPrice = 0;
    cachedProducts.forEach((product) {
      totalPrice += (product.price * product.quantity);
    });
    return totalPrice;
  }

  void _navigateToProfileScreen() {
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
          'Shopping Cart',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: _navigateToProfileScreen,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cachedProducts.length,
              itemBuilder: (context, index) {
                final product = cachedProducts[index];

                return ListTile(
                  leading: Image.network(
                    product.thumbnail,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 1) {
                              product.quantity--;
                            } else {
                              removeFromCart(product);
                            }
                          });
                        },
                      ),
                      Text(
                        product.quantity.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            addToCart(product);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
