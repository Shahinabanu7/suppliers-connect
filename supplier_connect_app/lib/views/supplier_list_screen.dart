import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:supplier_connect_app/constants/colors.dart';
import 'package:supplier_connect_app/model/supplier_model.dart';
import 'package:supplier_connect_app/presenters/supplier_presenter.dart';
import 'package:supplier_connect_app/provider/cart_provider.dart';
import 'package:supplier_connect_app/views/cart_screen.dart';
import 'package:supplier_connect_app/views/product_screen.dart';

import 'package:badges/badges.dart' as badges;

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  _SupplierListScreenState createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  final SupplierPresenter _presenter = SupplierPresenter();
  late Future<Supplier> _futureSuppliers;

  @override
  void initState() {
    super.initState();
    _futureSuppliers = _presenter.getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: lightpurple,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              child: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),

                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                child: badges.Badge(
                  child: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartPage()),
                );
              },
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Suppliers",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<Supplier>(
            future: _futureSuppliers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                return Center(child: Text('No suppliers found'));
              } else {
                final Supplier supplierData = snapshot.data!;
                List<Datum> suppliers = supplierData.data;

                return ListView.builder(
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = suppliers[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ProductScreen(
                                  id: supplier.id,
                                  name: supplier.name,
                                  type: supplier.category,
                                  rating: supplier.rating,
                                  image: supplier.logo,
                                ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: mintgrey, width: 0.5),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: lightgrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  supplier.logo,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Icon(
                                        Icons.image_not_supported,
                                        size: 60,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      supplier.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          supplier.rating.toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      supplier.category,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
