import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class NodeRedBlack<V> extends Node<V>{
  bool isRed = true;
  NodeRedBlack<V>? parent, _left, _right;

  NodeRedBlack<V>? get left => _left;
  NodeRedBlack<V>? get right => _right;

  set left(NodeRedBlack<V>? node){
    _left = node;
    _left?.parent = this;
  }

  set right(NodeRedBlack<V>? node){
    _right = node;
    _right?.parent = this;
  }

  NodeRedBlack(super.id, super.value);
}