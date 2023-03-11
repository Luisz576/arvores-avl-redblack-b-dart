import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreB<V> extends Arvore<V>{
  late final int maxDegree, minDegree;
  late NodeB<V> _root;

  @override
  V? find(id) {
    return _root.find(id);
  }

  @override
  insert(id, V value) {
    _root.insert(id, value);
    while(_root.parent != null){
      _root = _root.parent!;
    }
  }

  @override
  remove(id) {
    _root.remove(id);
  }

  ArvoreB.t(int t){
    maxDegree = 2*t - 1;
    minDegree = t - 1;
    _root = NodeB(maxDegree, minDegree);
  }
  ArvoreB.maxDegree(this.maxDegree){
    minDegree = ((maxDegree + 1) / 2).ceil() - 1;
    _root = NodeB(maxDegree, minDegree);
  }
  ArvoreB.minDegree(this.minDegree){
    maxDegree = 2*(minDegree+1) - 1;
    _root = NodeB(maxDegree, minDegree);
  }
}