


import 'package:flutter/material.dart';
import 'package:my_its_anime_list/features/manga/data/models/manga_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final MangaModel product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late MangaModel product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 4, 104),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 251, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
                image: DecorationImage(
                  image: NetworkImage(product.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Filters buttons
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Category : ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 242, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'times new roman',
                    ),
                  ),
                  Text(
                    product.genre.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 24,
                      ),
                      Text(
                        'Rating :',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 242, 0),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'times new roman',
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${product.readCount}',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 251, 0),
                      fontFamily: 'times new roman',
                    ),
                  ),
                ),
    
                SizedBox(width: 10),
              ],
            ),

            // Description text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(product.sinopsis,
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 255, 255, 255))),
            ),
          ],
        ),
      ),
    );
  }
}
