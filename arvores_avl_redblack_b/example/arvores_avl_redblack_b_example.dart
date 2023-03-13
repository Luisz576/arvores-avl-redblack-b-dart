import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

void main() {
  final avl = ArvoreAVL<String>();
  avl.insert(5, "cinco");
  avl.insert(2, "dois");
  avl.insert(10, "dez");
  avl.insert(4, "quatro");
  avl.insert(3, "três");
  avl.insert(9, "nove");
  avl.insert(8, "oito");
  avl.insert(1, "um");
  print(avl.find(3));
  avl.remove(3);
  avl.remove(5);
  avl.insert(11, "onze");
  avl.remove(9);
  print(avl.find(11));
  
  final redblack = ArvoreRedBlack();
  redblack.insert(5, "cinco");
  redblack.insert(2, "dois");
  redblack.insert(10, "dez");
  redblack.insert(3, "três");
  redblack.insert(4, "quatro");
  print(redblack.find(4));

  final b = TreeB<String>(2);
  b.insert(2, "dois");
  b.insert(1, "um");
  b.insert(3, "três");
  b.insert(7, "sete");
  b.insert(4, "quatro");
  b.insert(5, "cinco");
  b.insert(6, "seis");
  b.insert(0, "zero");
  b.insert(8, "oito");
  b.insert(9, "nove");
  b.insert(10, "dez");
  print(b.find(9));
  b.remove(9);
  b.insert(11, "onze");
  b.insert(12, "doze");
  print(b.find(12));
  print(b.find(9));
}