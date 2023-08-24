// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:product_tracking/constants/form_constants.dart';
import 'package:product_tracking/hive/hive_box.dart';
import 'package:product_tracking/hive/hive_class.dart';

class AddPOForm extends StatefulWidget {
  const AddPOForm({
    super.key,
  });

  @override
  State<AddPOForm> createState() => _AddPOFormState();
}

class _AddPOFormState extends State<AddPOForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController productNoController = TextEditingController();
  TextEditingController productDesController = TextEditingController();
  TextEditingController productDateController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  List<Map<String, dynamic>> items = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int count = 0;
  String title = 'Add Details';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ProductFormDetails(
                          controller: productNoController,
                          labelText: 'Product Number',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProductFormDetails(
                          keyboardType: TextInputType.number,
                          controller: productDesController,
                          labelText: 'Product Description',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProductFormDate(
                          controller: productDateController,
                          labelText: "Enter date",
                          keyboardType: TextInputType.number,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  final poNo =
                                      int.tryParse(productNoController.text);
                                  final poDate = DateTime.tryParse(
                                      productDateController.text);
                                  final poDescription =
                                      productDesController.text;
                                }
                                Navigator.pop(context);
                              },
                              child: Text(title),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Product Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.add(<String, dynamic>{});
                          });
                        },
                        child: const Text('Add Items'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 5,
                      child: Text('Item Name'),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Price'),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Quantity'),
                    ),
                    Expanded(
                      child: Text('Action'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Item Name',
                                  ),
                                  controller: itemNameController,
                                  onChanged: (value) {
                                    items[index]['product_name'] = value;
                                  },
                                ),
                              ),
                              const Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: itemPriceController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Item Price',
                                  ),
                                  onChanged: (value) {
                                    items[index]['product_price'] = value;
                                  },
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: itemQuantityController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Item quantity',
                                  ),
                                  onChanged: (value) {
                                    items[index]['product_quantity'] = value;
                                  },
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addDetails(int poNo, DateTime poDate, String poDescription,
      List<Map<String, dynamic>> items) async {
    final productDetail = ProductDetails()
      ..poNo = poNo
      ..poDate = poDate
      ..poDescription = poDescription
      ..items = items;
    final box = Boxes.getDetails();
    box.add(productDetail);
    debugPrint('box added');
  }

  @override
  void dispose() {
    super.dispose();
    productNoController.dispose();
    productDesController.dispose();
    productDateController.dispose();
  }
}
