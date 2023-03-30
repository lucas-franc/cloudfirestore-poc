import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestore_with_flutter/models/product.dart';
import 'package:cloudfirestore_with_flutter/views/new_product.dart';
import 'package:flutter/material.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({super.key});

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  List<Product> productsList = [];
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? productsSubscription;
  @override
  void initState() {
    super.initState();

    productsList = [];
    productsSubscription?.cancel();

    productsSubscription =
        db.collection('products').snapshots().listen((snapshot) {
      final List<Product> products = snapshot.docs
          .map(
            (documentSnapshot) =>
                Product.fromMap(documentSnapshot.data(), documentSnapshot.id),
          )
          .toList();
      setState(() {
        productsList = products;
      });
    });
  }

  @override
  void dispose() {
    productsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: StreamBuilder<QuerySnapshot>(
            stream: getProductsList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          productsList[index].name!,
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(
                          productsList[index].price!,
                          style: const TextStyle(fontSize: 22),
                        ),
                        leading: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                _delectProduct(
                                    context, documents[index], index);
                              },
                              icon: const Icon(Icons.delete_forever),
                            )
                          ],
                        ),
                        onTap: () =>
                            _navigateToProduct(context, productsList[index]),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewProduct(
          context,
          Product(),
        ),
      ),
    );
  }

  void _navigateToProduct(BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewProduct(
          product: product,
        ),
      ),
    );
  }

  void _createNewProduct(BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewProduct(
          product: Product(
            id: null,
            name: "",
            price: "",
          ),
        ),
      ),
    );
  }

  void _delectProduct(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection('products').doc(doc.id).delete();
    setState(() {
      productsList.removeAt(position);
    });
  }

  Stream<QuerySnapshot> getProductsList() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }
}
