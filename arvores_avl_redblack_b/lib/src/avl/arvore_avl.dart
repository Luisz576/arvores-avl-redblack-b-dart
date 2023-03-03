import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreAVL extends Arvore{
  NodeAVL? _root;

  @override
  insert(int value){
    NodeAVL? node = _root;
    while(node != null){
      if(node.value == value) return;
      if(node.value < value){
        if(node.left == null){
          break;
        }
      }
    }
  //TODO:
  }
  @override
  remove(int value){
    
  }

  @override
  foreach(Function(int) consumer){

  }
}