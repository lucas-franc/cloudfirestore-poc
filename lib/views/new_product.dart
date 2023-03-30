import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key, required this.product});

  final Product product;

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final db = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  label: Text('Price'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.product.id != null) {
                    db.collection('products').doc(widget.product.id).set(
                      {
                        'name': nameController.text,
                        'price': priceController.text,
                      },
                    );
                    Navigator.pop(context);
                  } else {
                    db.collection('products').doc(widget.product.id).set(
                      {
                        'name': nameController.text,
                        'price': priceController.text,
                      },
                    );
                    Navigator.pop(context);
                  }
                },
                child: (widget.product.id != null)
                    ? const Text('Edit')
                    : const Text('New'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
