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
  b.remove(2);
  b.remove(1);
  print(b.find(12));
  b.insert(20, "vinte");
  b.insert(22, "vinte e dois");
  b.insert(24, "vinte e quatro");
  b.insert(26, "vinte e seis");
  b.insert(27, "vinte e sete");
  b.insert(28, "vinte e oito");
  b.insert(29, "vinte e nove");
  b.insert(30, "trinta");
  b.insert(31, "trinta e um");
  b.insert(32, "trinta e dois");
  b.insert(33, "trinta e três");
  b.insert(40, "quarenta");
  b.insert(41, "quarenta e um");
  String w = "";
  b.getPath(41)?.forEach((e) {
    if(w == ""){
      w = e;
      return;
    }
    w += " -> $e";
  });
  print(w);
}