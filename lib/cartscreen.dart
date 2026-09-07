import 'package:flutter/material.dart';
import 'main.dart';
class CartScreen extends StatefulWidget {

  final List<CartItem> cart;

  const CartScreen({
    super.key,
    required this.cart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
  
}
class _CartScreenState extends State<CartScreen> {
  double calculateTotal(){
    double total = 0;
    for(var item in widget.cart){
      total = total + (item.product.price * item.quantity);
    }
    return total;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, index) {
          final CartItem = widget.cart[index];
          return Card(
            child: ListTile(
              leading: Image.asset(
                CartItem.product.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                ),
                title: Text(CartItem.product.name),
                subtitle: Text('\$${CartItem.product.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  
                     children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (CartItem.quantity > 1) {
                        CartItem.quantity--;
                      } else {
                        widget.cart.removeAt(index);
                      }
                    });
                  },
                ),
                Text('${CartItem.quantity}'),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      CartItem.quantity++;
                    });
                  },
                ),
              ],
                  
                ),
            ),
          
          );
        },

      ),
    
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Total :\$${calculateTotal().toStringAsFixed(2)}', style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        
        ),
    ),
    );
  }
}