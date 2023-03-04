import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreB<V> extends Arvore<V>{
  final int maxDegree;
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

  ArvoreB(this.maxDegree){
    _root = NodeB(maxDegree);
  }
}