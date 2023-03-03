import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

void main() {
  final avl = ArvoreAVL<String>();
  avl.insert(2, "dois");
  avl.insert(1, "um");
  avl.insert(3, "três");
  print(avl.find(3));
  
  final redblack = ArvoreRedBlack();

  final b = ArvoreB(3);
  b.insert(2, "dois");
  b.insert(1, "um");
  b.insert(3, "três");
  b.insert(4, "quatro");
  print(b.find(4));
}