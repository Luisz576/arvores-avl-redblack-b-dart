import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';

class NodeB<V>{
  final NodeBElement _empty = NodeBElement();

  final int size;
  final List<NodeBElement> _elements = [];
  NodeB? rightChild;

  bool contains(id){
    return _elements.any((element) => element.id == id);
  }

  V? get(id){
    if(contains(id)){
      return _elements.firstWhere((element) => element.id == id).value;
    }
    NodeB<dynamic>? child = _elements.firstWhere((element) => element.id != null && element.id > id, orElse: () => _empty).leftChild;
    if(child == null){
      if(rightChild == null){
        return null;
      }
      return rightChild!.get(id);
    }
    return child.get(id);
  }

  insert(id, value){
    //TODO: split if more than size
  }

  NodeB(this.size){
    for(int i = 0; i < size; i++){
      _elements.add(NodeBElement());
    }
  }
}