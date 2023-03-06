import 'dart:math';

import 'package:arvores_avl_redblack_b/src/interfaces/node.dart';

class NodeAVL<V> extends Node<V>{
  NodeAVL<V>? parent, left, right;

  int get height{
    return 1 + max(leftHeight, rightHeight);
  }
  int get leftHeight => left == null ? 0 : left!.height;
  int get rightHeight => right == null ? 0 : right!.height;

  int get weight => rightHeight - leftHeight;

  NodeAVL(super.id, super.value, this.parent);
}