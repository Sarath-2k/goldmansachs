import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:goldmansachs/order_model.dart';
import 'package:goldmansachs/screens/addProduct.dart';
import 'package:goldmansachs/screens/loginScreen.dart';
import 'package:goldmansachs/screens/processFinalOrder.dart';
import 'package:goldmansachs/screens/productpage.dart';
import 'package:goldmansachs/share.dart';

import '../product.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int shareCount = 0;
  List<ShareProduct> shareProductList = [];
  List<String> shareProductItemCodeList = [];

  // String filterContent = '';
  String selectedChoice = 'All Items';
  List<Product> filteredListProducts = [];
  List<String> filterListCategory = ['All Items'] + listCategory;

  @override
  void initState() {
    super.initState();
    getProductsFromFirestore();
    filteredListProducts = products;
    print("\n Entered homescreen init \n");
    print("\n\n");
  }

  getProductsFromFirestore() {
    products = [];
    final CollectionReference productsCollection = FirebaseFirestore.instance
        .collection(uid)
        .doc('products')
        .collection('products');

    productsCollection.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()['imgSrc']);

        Product product = Product(
          itemCode: element.data()['code'],
          weight: element.data()['weight'],
          imgSrc: element.data()['imgSrc'],
          category: element.data()['category'],
          description: element.data()['description'],
          size: element.data()['size'],
        );
        products.add(product);
      });
      print('\n\n\n processing complete');
    }).then((_) {
      setState(() {});
    });
  }

  filterChoiceChipProducts(String filterCategory) {
    filteredListProducts = [];
    products.forEach((element) {
      if (element.category.contains(filterCategory))
        filteredListProducts.add(element);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushReplacement(
              (context),
              MaterialPageRoute(
                builder: (context) => Details(),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                if (shareProductList.length > 0) {
                  shareOut(shareProductList);
                  shareProductList = [];
                  shareProductItemCodeList = [];
                  setState(() {
                    shareCount = 0;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Text(
                                    'No products selected to share!!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )));
                }
              }),
          IconButton(
              icon: Icon(Icons.refresh), onPressed: getProductsFromFirestore),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (orderItems.length > 0) {
                  // initializeOrder();
                  // reportView(context);
                  // orderItems = [];
                  print(orderItems);
                  processOrderForm(context);
                  setState(() {});
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: Text(
                                'No products added to process order!!',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ],
      ),
      drawer: Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DrawerLogoWidget("BB GOLD"),
              Container(
                margin: EdgeInsets.only(bottom: 6, top: 4),
                child: DrawerListItem("ALL ITEMS"),
              ),
              Column(
                  children: listCategory
                      .map((e) => DrawerListItem(e.toUpperCase()))
                      .toList())
            ]),
      ),
      body: Column(
        children: [
          buildFilterChips(context),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.82,
            child: GridView.builder(
              itemCount: filteredListProducts.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) =>
                  buildProductTile(filteredListProducts, context, index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: null,
          child: Text(orderItems.length.toString(),
              style: TextStyle(fontSize: 24))),
    );
  }

  Container buildFilterChips(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: filterListCategory
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ChoiceChip(
                      backgroundColor: Colors.grey[300],
                      label: Text(e),
                      labelStyle: TextStyle(
                          color: selectedChoice == e
                              ? Colors.white
                              : Colors.black),
                      selected: selectedChoice == e,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedChoice = e;
                          (e == 'All Items')
                              ? filteredListProducts = products
                              : filterChoiceChipProducts(e);
                        });
                      },
                      selectedColor: Theme.of(context).accentColor,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  buildProductTile(List<Product> products, BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 1,
              blurRadius: 6,
              // offset: Offset(1, 1)
            )
          ],
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                product: products[index],
              ),
            ),
          ),
          onLongPress: () {
            bool search = false;
            int counter = 0;
            int indexToDelete = -1;
            shareProductList.forEach((element) {
              if (products[index].itemCode == element.fileName) {
                search = true;
                indexToDelete = counter;
              }
              counter++;
            });

            if (search) {
              // showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //             title: Text(
              //           'Removed from share!',
              //           style: TextStyle(
              //               fontSize: 24, fontWeight: FontWeight.bold),
              //         )));
              shareProductList.removeAt(indexToDelete);
              shareProductItemCodeList.removeAt(indexToDelete);
              setState(() {
                shareCount--;
              });
            } else {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: LinearProgressIndicator(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Adding to share!',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ));
              getBytes(products[index].imgSrc).then((bytes) {
                ShareProduct share = ShareProduct(
                    fileName: products[index].itemCode,
                    downloadUrl: products[index].imgSrc,
                    bytes: bytes);
                shareProductList.add(share);
                shareProductItemCodeList.add(products[index].itemCode);
                print('added');
                setState(() {
                  shareCount++;
                });

                Navigator.pop(context);
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Stack(children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        products[index].imgSrc,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  (shareProductItemCodeList.contains(products[index].itemCode))
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ],
                        )
                      : Container(),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    products[index].itemCode,
                    maxLines: 1,
                    // softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1.6),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      '${products[index].weight}g',
                      softWrap: false,
                      // maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 1.3),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class DrawerLogoWidget extends StatelessWidget {
  final String _logoText;
  const DrawerLogoWidget(this._logoText);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        _logoText,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 36,
            letterSpacing: 4),
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final String _itemText;
  const DrawerListItem(this._itemText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      width: double.infinity,
      height: 50,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          print("tap");
        },
        splashColor: Colors.white,
        child: Center(
          child: Text(
            _itemText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
