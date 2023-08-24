import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:product_tracking/hive/hive_box.dart';
import 'package:product_tracking/hive/hive_class.dart';
import 'package:product_tracking/screens/add_po_form.dart';
import 'package:product_tracking/screens/edit_po_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    Hive.box('products').close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Tracking'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addPO');
          },
          child: const Icon(Icons.add),
        ),
        body: ValueListenableBuilder<Box<ProductDetails>>(
          valueListenable: Boxes.getDetails().listenable(),
          builder: (context, box, _) {
            final products = box.values.toList().cast<ProductDetails>();
            return buildContext(products);
          },
        ),
      ),
    );
  }

  Widget buildContext(List<ProductDetails> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('No Details'),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final productdetails = products[index];
                return buildDetails(context, productdetails);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildDetails(BuildContext context, ProductDetails productdetail) {
    final doc = DateFormat.yMMMd().format(productdetail.poDate!);
    final no = (productdetail.poNo != null) ? productdetail.poNo! : 0;

    return Card(
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ('Product Id:$no'),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Description :${productdetail.poDescription}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              'Date :$doc',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: const ButtonStyle(),
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditPOForm(
                          values: productdetail,
                          onClickedDone: (
                            poNo,
                            poDate,
                            poDescription,
                            items,
                          ) =>
                              editDetails(
                            productdetail,
                            poNo,
                            poDescription,
                            poDate,
                            items,
                          ),
                        ),
                      ),
                    );
                  },
                  label: const Text('Edit'),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteDetails(productdetail),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future addDetails(
      int poNo, DateTime poDate, String poDescription, items) async {
    final productDetail = ProductDetails()
      ..poNo = poNo
      ..poDate = poDate
      ..poDescription = poDescription
      ..items = items;
    final box = Boxes.getDetails();
    box.add(productDetail);
  }

  editDetails(ProductDetails productdetail, int poNo, String poDescription,
      DateTime poDate, List<Map<String, dynamic>> items) {
    productdetail.poDate = poDate;
    productdetail.poNo = poNo;
    productdetail.poDescription = poDescription;
    productdetail.items = items;
    productdetail.save();
  }

  deleteDetails(ProductDetails products) {
    products.delete();
  }
}
