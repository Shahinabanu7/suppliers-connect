import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplier_connect_app/constants/colors.dart';
import 'package:supplier_connect_app/presenters/order_presenter.dart';
import 'package:supplier_connect_app/provider/cart_provider.dart';
import 'package:supplier_connect_app/views/order_success_screen.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartProduct> cartlist = [];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: lightpurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Cart", style: TextStyle(fontSize: 25, color: white)),

        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(
                onPressed: () {
                  context.read<Cart>().clearCart();
                },
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.delete, color: white),
                ),
              ),
        ],
      ),
      body:
          context.watch<Cart>().getItems.isEmpty
              ? Center(child: Text("Empty Cart"))
              : Consumer<Cart>(
                builder: (context, cart, child) {
                  cartlist = cart.getItems;
                  return ListView.builder(
                    itemCount: cart.count,

                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: lightgrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: mintgrey, width: 0.5),
                          ),
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 9),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            cart.getItems[index].imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //child:
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            // "Product name",
                                            cartlist[index].name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,

                                            children: [
                                              Text(
                                                "AED ${cartlist[index].price.toString()}",

                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    62,
                                                    158,
                                                    65,
                                                  ),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child:
                                                //.....
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        cart.getItems[index].qty ==
                                                                1
                                                            ? cart.removeItem(
                                                              cart.getItems[index],
                                                            )
                                                            : cart.reduceByOne(
                                                              cart.getItems[index],
                                                            );
                                                      },
                                                      icon:
                                                          cartlist[index].qty ==
                                                                  1
                                                              ? Icon(
                                                                Icons.delete,
                                                                size: 20,
                                                              )
                                                              : Icon(
                                                                Icons.remove,
                                                                size: 20,
                                                              ),
                                                    ),

                                                    Text(
                                                      cartlist[index].qty
                                                          .toString(),

                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.red.shade900,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        cart.increment(
                                                          cart.getItems[index],
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

      bottomSheet: Container(
        color: lightgrey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Total : ${context.watch<Cart>().totalPrice} AED",
                  style: TextStyle(
                    fontSize: 20,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap:
                    _isLoading
                        ? null
                        : () async {
                          final cart = context.read<Cart>();
                          final presenter = OrderPresenter();

                          if (cart.getItems.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                content: Text(
                                  "Cart is Empty !!!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              _isLoading = true;
                            });

                            bool success = await presenter.placeOrder(
                              cart.getItems,
                            );
                            setState(() {
                              _isLoading = false;
                            });

                            if (success) {
                              cart.clearCart();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SuccessScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  content: Text(
                                    "Order failed!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: _isLoading ? Colors.grey : lightpurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child:
                        _isLoading
                            ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : const Text(
                              "Order Now",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
