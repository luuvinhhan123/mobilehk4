// import 'package:flutter/material.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';

// import '../details/details_screen.dart';

// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});

//   static String routeName = "/products";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Products"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: GridView.builder(
//             itemCount: demoProducts.length,
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200,
//               childAspectRatio: 0.7,
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 16,
//             ),
//             itemBuilder: (context, index) => ProductCard(
//               product: demoProducts[index],
//               onPress: () => Navigator.pushNamed(
//                 context,
//                 DetailsScreen.routeName,
//                 arguments:
//                     ProductDetailsArguments(product: demoProducts[index]),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shop_app/services/product_service.dart';

class ProductsScreen extends StatefulWidget {
    const ProductsScreen({super.key});

  static String routeName = "/products";
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsFuture;
  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            productId: snapshot.data![index].id,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Center(
        child: FutureBuilder<Product>(
          future: ProductService().getProductDetails(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!.title,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(snapshot.data!.description),
                  SizedBox(height: 8),
                  Text('Price: \$${snapshot.data!.price.toStringAsFixed(2)}'),
                  // Image.network(
                  //   snapshot.data!.imageUrl,
                  //   height: 200,
                  //   width: 200,
                  //   fit: BoxFit.cover,
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
