import 'package:flutter/material.dart';
import 'package:ahmed_wael_ecommerce_app/model/model.dart';
import 'package:ahmed_wael_ecommerce_app/service/service.dart';
import 'package:ahmed_wael_ecommerce_app/profile.dart';
import 'package:ahmed_wael_ecommerce_app/product_details.dart';
import 'package:ahmed_wael_ecommerce_app/shopping_cart.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Model>> productsFuture;
  final Service service = Service();
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    productsFuture = _fetchProducts();
  }

  Future<List<Model>> _fetchProducts() async {
    try {
      final List<Model> fetchedProducts = await service.fetchProducts();
      return fetchedProducts;
    } catch (e) {
      print("Failed to fetch products: $e");
      throw e;
    }
  }

  List<String> getUniqueCategories(List<Model> products) {
    Set<String> uniqueCategories = Set();
    for (var product in products) {
      uniqueCategories.add(product.category);
    }
    return uniqueCategories.toList();
  }

  void _navigateToProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _navigateToProductDetails(Model product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  void _navigateToShoppingCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
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
      body: FutureBuilder<List<Model>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load products',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No products available',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final products = snapshot.data!;
            final uniqueCategories = getUniqueCategories(products);

            final filteredProducts = selectedCategory.isEmpty
                ? products
                : products
                    .where((product) => product.category == selectedCategory)
                    .toList();

            return Stack(
              children: [
                Column(
                  children: [
                    DropdownButton<String>(
                      value: selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      items: <String>['', ...uniqueCategories]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.isEmpty ? 'All Categories' : value,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.black,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onProductDetails: _navigateToProductDetails,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: _navigateToShoppingCart,
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Model product;
  final Function(Model) onProductDetails;

  ProductCard({required this.product, required this.onProductDetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductDetails(product),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18,
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
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Discount: ${product.discountPercentage.toStringAsFixed(2)}%',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
