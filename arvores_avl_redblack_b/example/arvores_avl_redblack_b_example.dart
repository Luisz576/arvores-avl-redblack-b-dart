import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

void main() {
  final avl = ArvoreAVL<String>();
  avl.insert(5, "cinco");
  avl.insert(2, "dois");
  avl.insert(10, "dez");
  avl.insert(4, "quatro");
  avl.insert(3, "três");
  print(avl.find(3));
  
  final redblack = ArvoreRedBlack();

  final b = ArvoreB(3);
  b.insert(2, "dois");
  b.insert(1, "um");
  b.insert(3, "três");
  b.insert(7, "sete");
  b.insert(4, "quatro");
  b.insert(5, "cinco");
  b.insert(6, "seis");
  b.insert(0, "zero");
  b.insert(8, "oito");
  b.insert(9, "oito");
  b.insert(10, "oito");
  print(b.find(5));
}