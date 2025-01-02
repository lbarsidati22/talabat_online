import 'package:talabat_online/model/prudact_item_model.dart';

class AddToCartModel {
  final String id;
  final PrudactItemModel prudact;
  final PrudactSize size;
  final int quantity;

  AddToCartModel({
    required this.prudact,
    required this.id,
    required this.size,
    required this.quantity,
  });
  double get totalPrice => prudact.price * quantity;

  AddToCartModel copyWith({
    String? id,
    PrudactItemModel? prudact,
    PrudactSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      prudact: prudact ?? this.prudact,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];
