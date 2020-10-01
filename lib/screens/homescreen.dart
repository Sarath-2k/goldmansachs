import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldmansachs/screens/formpage.dart';
import 'package:goldmansachs/screens/loginScreen.dart';

import '../product.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getProductsFromFirestore();
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
          decsription: element.data()['description'],
          size: element.data()['size'],
        );
        products.add(product);
      });
      print('\n\n\n processing complete');
    }).then((_) {
      setState(() {});
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
              icon: Icon(Icons.refresh),
              onPressed: getProductsFromFirestore)
        ],
      ),
      drawer: Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DrawerLogoWidget("BB GOLD"),
              Container(
                  margin: EdgeInsets.only(bottom: 6, top: 4),
                  child: DrawerListItem("ALL ITEMS")),
              DrawerListItem("CHAIN"),
              DrawerListItem("PENDANT"),
              DrawerListItem("EAR RING"),
              DrawerListItem("NECKLACE"),
              DrawerListItem("FINGER RING"),
            ]),
      ),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, index) {
          return ProductTile(
            titleText: products[index].itemCode,
            subtitleText: products[index].weight,
            imageSrc: products[index].imgSrc,
          );
        },
        // body: GridView.count(
        //   // semanticChildCount: 2,
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        //   mainAxisSpacing: 10,
        //   crossAxisSpacing: 10,
        //   crossAxisCount: 2,
        //   children: [
        //     ProductTile(
        //       titleText: 'iPhone 7',
        //       subtitleText: 'Apple | 256 GB | 5.5\" LCD',
        //       imageSrc:
        //           'https://i.ndtvimg.com/video/images/vod/medium/2016-09/big_430454_1473307705.jpg?downsize=600:450',
        //     ),
        //   ],
        // ),
      ),
    );
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

class ProductTile extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final String imageSrc;
  ProductTile(
      {@required this.titleText,
      @required this.subtitleText,
      @required this.imageSrc});
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              titleText,
              maxLines: 1,
              // softWrap: false,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.7),
            ),
            Text(
              '${subtitleText}g',
              softWrap: false,
              // maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(letterSpacing: 1.3),
            )
          ],
        ));
  }
}
