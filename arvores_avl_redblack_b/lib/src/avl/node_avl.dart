import 'dart:math';

import 'package:arvores_avl_redblack_b/src/interfaces/node.dart';

class NodeAVL<V> extends Node<V>{
  NodeAVL<V>? parent, _left, _right;

  NodeAVL<V>? get left => _left;
  NodeAVL<V>? get right => _right;

  set right(NodeAVL<V>? node){
    _right = node;
    _right?.parent = this;
  }

  set left(NodeAVL<V>? node){
    _left = node;
    _left?.parent = this;
  }

  int get height{
    return 1 + max(leftHeight, rightHeight);
  }
  int get leftHeight => left == null ? 0 : left!.height;
  int get rightHeight => right == null ? 0 : right!.height;

  int get weight => rightHeight - leftHeight;

  NodeAVL(super.id, super.value, this.parent);
}