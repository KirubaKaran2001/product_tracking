import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_tracking/hive/hive_class.dart';

class Boxes {
  static Box<ProductDetails> getDetails() => Hive.box<ProductDetails>('products');
}
