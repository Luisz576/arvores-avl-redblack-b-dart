import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreB<V> extends Arvore<V>{
  final int maxDegree;
  late final NodeB _root;

  @override
  V? find(id) {
    return _root.get(id);
  }

  @override
  insert(id, V value) {
    //TODO:
  }

  @override
  remove(id) {

  }

  ArvoreB(this.maxDegree){
    _root = NodeB(maxDegree);
  }
}