import 'package:flutter/material.dart';
import 'main.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$product.name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Text(
              product.name, style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
              ),
              const SizedBox(height: 8,),
              Text('\$${product.price.toStringAsFixed(2)}'),
              const SizedBox(height: 24),
ElevatedButton(
  onPressed: () {
  onAddToCart(product);
  },
  child: Text('Add to Cart'),
),
          ],
        ),
      )
    );
  }
}