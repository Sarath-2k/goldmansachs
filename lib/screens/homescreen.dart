import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        // semanticChildCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          ProductTile(
            titleText: 'iPhone 7',
            subtitleText: 'Apple | 256 GB | 5.5\" LCD',
            imageSrc:
                'https://i.ndtvimg.com/video/images/vod/medium/2016-09/big_430454_1473307705.jpg?downsize=600:450',
          ),
          ProductTile(
            titleText: 'iPhone X',
            subtitleText: 'Apple | 128 GB | 6.2\" OLED',
            imageSrc:
                'https://drop.ndtv.com/TECH/product_database/images/913201720152AM_635_iphone_x.jpeg',
          ),
          ProductTile(
            titleText: 'MacBook Pro 15\" 2020',
            subtitleText: 'Apple | 16 GB | 512 GB SSD',
            imageSrc:
                'https://images-na.ssl-images-amazon.com/images/I/71L2iBSyyOL._SL1500_.jpg',
          ),
        ],
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
                  padding: const EdgeInsets.all(6.0),
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
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitleText,
              softWrap: false,
              // maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ));
  }
}
