import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class NodeBElement<V>{
  late final dynamic _id;
  late final V? _value;

  dynamic get id => _id;
  V get value => _value!;

  NodeB<V>? leftChild;

  NodeBElement(this._id, this._value);
  NodeBElement.empty(){
    this._id = -1;
    this._value = null;
  }
}