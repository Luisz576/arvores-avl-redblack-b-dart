import 'package:arvores_avl_redblack_b/src/interfaces/node.dart';

class NodeAVL extends Node<NodeAVL>{
  int get height => (left == null ? 0 : left!.height) - (right == null ? 0 : right!.height);

  NodeAVL(int value, NodeAVL? left, NodeAVL? right)
    : super(value, left, right);
}