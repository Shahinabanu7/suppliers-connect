import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplier_connect_app/constants/colors.dart';
import 'package:supplier_connect_app/model/product_model.dart';
import 'package:supplier_connect_app/presenters/product_presenters.dart';
import 'package:supplier_connect_app/provider/cart_provider.dart';

import 'package:collection/collection.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  final String name;
  final String rating;
  final String type;
  final String image;

  const ProductScreen({
    super.key,
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    required this.image,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<SupplierDetail> _supplierDetailFuture;
  final SupplierDetailPresenter _presenter = SupplierDetailPresenter();

  @override
  void initState() {
    super.initState();
    _supplierDetailFuture = _presenter.fetchSupplierDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: lightpurple,
        title: Text(
          'Products',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<SupplierDetail>(
        future: _supplierDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          final products = snapshot.data!.products;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  name: product.name,
                  price: "AED ${product.price}",
                  imageUrl: product.image, id: product.id.toString(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
   final String id;
  final String name;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    color: lightgrey,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: mintgrey),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.network(
        imageUrl,
        height: 80,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
      ),
      Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      Text(price, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
      ElevatedButton(
        onPressed: () {
          var existingItemCart = context
              .read<Cart>()
              .getItems
              .firstWhereOrNull((element) => element.id == id);

          if (existingItemCart != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                content: Text(
                  "This item already in cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "muli",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            context.read<Cart>().addItem(
              id,
              name,
             double.parse(price.replaceAll("AED", "").trim()),
              1,
              imageUrl,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                content: Text(
                  "Added to cart !!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "muli",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }

          // // Optional: Navigate to cart page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => CartPage()),
          // );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: lightpurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: const Size(double.infinity, 36),
        ),
        child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
);

  }
}


