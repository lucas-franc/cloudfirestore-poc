import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudfirestore_with_flutter/models/product.dart';
import 'package:flutter/material.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({super.key});

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  List<Product> products = [];
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? productsSubscription;
  @override
  void initState() {
    super.initState();
  }

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
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
