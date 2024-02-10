import 'dart:convert';
import 'package:bookbyte_user/billscreen.dart';
import 'package:bookbyte_user/models/cart.dart';
import 'package:bookbyte_user/models/user.dart';
import 'package:bookbyte_user/serverconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final User user;
  final Cart cart;

  const CartPage({super.key, required this.user, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartList = <Cart>[];
  double total = 0.0;
  @override
  void initState() {
    super.initState();
    loadUserCart();
  }

  Future<void> _refresh() async {
    // Handle your refresh logic here
    loadUserCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("My Cart")),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: cartList.isEmpty
              ? const Center(
                  child: Text("No Data"),
                )
              : Column(children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: Row(children: [
                                IconButton(
                                    onPressed: deleteCart,
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.update))
                              ]),
                            ),
                            key: Key(cartList[index].bookId.toString()),
                            child: ListTile(
                                title:
                                    Text(cartList[index].bookTitle.toString()),
                                onTap: () async {},
                                subtitle:
                                    Text("RM ${cartList[index].bookPrice}"),
                                leading: const Icon(Icons.sell),
                                trailing:
                                    Text("x ${cartList[index].cartQty} unit")),
                          );
                        }),
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TOTAL RM ${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) => BillScreen(
                                              user: widget.user,
                                              totalprice: total,
                                            )));
                                loadUserCart();
                              },
                              child: const Text("Pay Now"))
                        ],
                      ))
                ]),
        ));
  }

  void loadUserCart() {
    String userid = widget.user.userid.toString();
    http
        .get(
      Uri.parse(
          "${ServerConfig.server}/bookbyte/php/load_cart.php?userid=$userid"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        // log(response.body);
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          cartList.clear();
          total = 0.0;
          data['data']['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));
            total = total +
                double.parse(v['book_price'] * int.parse(v['cart_qty']));
            setState(() {});
          });
          print(total);
          setState(() {});
        } else {
          Navigator.of(context).pop();
          //if no status failed
        }
      }
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      print("Timeout");
    });
  }

  void deleteCart() {
    http.post(Uri.parse("${ServerConfig.server}/bookbyte/php/delete_cart.php"),
        body: {
          "cart_id": widget.cart.cartId.toString(),
          "buyer_id": widget.user.userid.toString(),
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          cartList.clear();
          total = 0.0;
          data['data']['carts'].forEach((v) {
            cartList.remove(Cart.fromJson(v));
            total = total -
                double.parse(v['book_price'] * int.parse(v['cart_qty']));
            setState(() {});
          });
          print(total);
          setState(() {});

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (content) => const LoginPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
