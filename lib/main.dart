import 'package:flutter/material.dart';
import 'cartscreen.dart';
import 'productdetailscreen.dart';
void main (){
  runApp(
    MaterialApp(
home: ProductListScreen()

  )
  );
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isDarkMode = false;

  void addToCart(Product product){
    setState(() {
      bool found = false;
      for(var item in cart){
        if(item.product == product){
           item.quantity++;
         found = true;
        break;
        }
       
      }
      if(!found){
        cart.add(CartItem(product: product));
      }
    });

  }
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();
  List<Product> products = [
    Product(name: 'burger', category: 'food', price: 450, imagePath: 'assets/images/burger.jfif'),
    Product(name: 'pizza', category: 'food', price: 900, imagePath: 'assets/images/pizza.jfif'),
    Product(name: 'sandwich', category: 'food', price: 350, imagePath: 'assets/images/sandwish.jfif'),
    Product(name: 'coffee', category: 'food', price: 250, imagePath: 'assets/images/coffe.jfif'),
    Product(name: 'shirt', category: 'fashion', price: 1800, imagePath: 'assets/images/shirt.jfif'),
    Product(name: 'pants', category: 'fashion', price: 1800, imagePath: 'assets/images/pent.jfif'),
    Product(name: 'cap', category: 'fashion', price: 800, imagePath: 'assets/images/cap.jfif'),
    Product(name: 'belt', category: 'fashion', price: 1000, imagePath: 'assets/images/belt.jfif'),
  ];
  List <CartItem> cart = [];

  List<Product> get foodProducts {
    return products.where((product) {
      return product.category == 'food' && product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  List<Product> get fashionProducts {
    return products.where((product) {
      return product.category == 'fashion'&& product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        
          IconButton(
            onPressed:  () async{
             await Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => CartScreen(cart: cart)
                  )
                );

          },
           icon: Icon(Icons.shopping_cart)),
           Text('${cart.length}'),
           SizedBox(width: 16,)
        ],
        title: Center(child: Text('Food & Fashion App')),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchQuery = value;
                });
              },
              onSubmitted: (value){
             
                 searchController.clear();
              },
             decoration: InputDecoration(
            
              hintText: 'search product',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
             ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            
            child: Center(
              child: Text(
                'Food Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foodProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final item = foodProducts[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                
                
             child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    
                    product: item, 
                    onAddToCart: addToCart,
                    ),
                  ),
                  );
              },
              child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                item.imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('\$${item.price.toStringAsFixed(2)}'),
const SizedBox(height: 8),
IconButton(
  onPressed: () {
    addToCart(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        duration: Duration(seconds: 1),
      ),
    );
  },
  icon: Icon(Icons.add_shopping_cart),
),
        ],
      ),
             ),
              );
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "FASHION Products",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: fashionProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final item = fashionProducts[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context)=> ProductDetailScreen(
                          product: item, onAddToCart: addToCart
                          )
                        )
                      );
                  },
child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)
                        ),
                        child: Image.asset(
                          item.imagePath,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    
                    ),
                       const SizedBox(height: 8),
    Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
    Text('\$${item.price.toStringAsFixed(2)}'),
    const SizedBox(height: 8),
    IconButton(onPressed:(){
     addToCart(item);
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} add to cart '),
      duration: Duration(seconds: 1),
      )
      );
    }, 
    
     icon:
    Icon(Icons.add_shopping_cart)
    )

                  ],
                ),
                ),
              );
            },
          )
        ]
      )
    );
  }
}
class Product{
  final String name;
  final String category;
  final double price;
  final String imagePath;
  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath
  }
  );
}
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}