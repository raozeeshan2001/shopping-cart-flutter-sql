import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_model.dart';
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/db_helper.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DbHelper dbHelper = DbHelper();
  List<String> productname = [
    'Banana',
    'Apple',
    'Mango',
    'Cherry',
    ' Orange',
    'Grapes'
  ];
  List<String> productunit = ['Dozen', 'Kg', 'Kg', 'Kg', 'Dozen', 'Kg'];
  List<int> productprice = [10, 25, 36, 85, 60, 90];
  List<String> images = [
    'https://www.shutterstock.com/shutterstock/photos/2474380581/display_1500/stock-photo-banana-bunch-banana-fruit-clipping-path-banana-isolated-on-white-background-banana-macro-studio-2474380581.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2476681597/display_1500/stock-photo-pink-fuji-apple-isolated-on-white-background-fresh-pink-japanese-apple-with-leaf-on-white-2476681597.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2474794949/display_1500/stock-photo-mango-isolated-ripe-red-mango-with-leaf-on-white-background-with-clipping-path-full-depth-of-2474794949.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2519733627/display_1500/stock-photo-cherry-with-stem-and-leaves-isolated-on-white-background-2519733627.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2516801939/display_1500/stock-photo-orange-isolated-on-white-background-arancia-tarocco-citrus-sinensis-2516801939.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2490657677/display_1500/stock-photo-fresh-green-grape-cluster-isolated-on-white-background-2490657677.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List '),
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getcounter().toString());
                },
                //child: Text('2')
              ),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productname.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                  height: 100,
                                  width: 100,
                                  image:
                                      NetworkImage(images[index].toString())),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productname[index].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      productunit[index].toString() +
                                          "" +
                                          r" $" +
                                          productprice[index].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          dbHelper
                                              .insert(CartModel(
                                                  id: index,
                                                  productId: index.toString(),
                                                  productName:
                                                      productname[index]
                                                          .toString(),
                                                  initialPrice:
                                                      productprice[index],
                                                  productPrice:
                                                      productprice[index],
                                                  quantity: 1,
                                                  unitTag: productunit[index],
                                                  image: images[index]))
                                              .then(
                                            (value) {
                                              cart.addtotalprice(double.parse(
                                                  productprice[index]
                                                      .toString()));
                                              cart.addcounter();
                                            },
                                          ).onError((error, stackTrace) {
                                            print(error.toString());
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.green[400],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
