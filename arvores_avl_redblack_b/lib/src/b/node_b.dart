import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';
import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';

class NodeB<V> extends Arvore<V>{
  final NodeBElement<V> _empty = NodeBElement.empty();

  final int maxDegree;
  final List<NodeBElement<V>> _elements = [];
  NodeB<V>? parent, rightChild;

  int get lenght => _elements.length;

  bool contains(id){
    return _elements.any((element) => element.id == id);
  }

  @override
  V? find(id) {
    if(contains(id)){
      return _elements.firstWhere((element) => element.id == id).value;
    }
    NodeB<dynamic>? child = _elements.firstWhere((element) => element.id != null && element.id > id, orElse: () => _empty).leftChild;
    if(child == null){
      if(rightChild == null){
        return null;
      }
      return rightChild!.find(id);
    }
    return child.find(id);
  }

  insertNodeWithRight(NodeBElement<V> n, NodeB<V> r){
    _elements.add(n);
    sort();
    if(_elements.last == n){
      rightChild = r;
    }else{
      NodeBElement<V> nextToN = _elements.firstWhere((element) => element.id > n.id);
      nextToN.leftChild = r;
    }
    _verifyAndSortIfItNeeds();
  }

  insertNode(NodeBElement<V> n){
    _elements.add(n);
    sort();
    _verifyAndSortIfItNeeds();
  }

  _verifyAndSortIfItNeeds(){
    if(lenght > maxDegree){
      int middle = (maxDegree / 2).ceil() - 1;
      NodeBElement<V> element = _elements.removeAt(middle);
      NodeB<V>? rightToRight = rightChild;
      rightChild = element.leftChild;
      element.leftChild = this;

      NodeB<V> rightNode = NodeB<V>(maxDegree);
      while(_elements.length > middle){
        rightNode.insertNode(_elements.removeAt(middle));
      }
      rightNode.rightChild = rightToRight;
      rightNode.sort();
      
      if(parent == null){
        NodeB<V> newParent = NodeB<V>(maxDegree);
        parent = newParent;
      }
      parent!.insertNodeWithRight(element, rightNode);
    }
  }

  sort(){
    _elements.sort((a, b) => a.id > b.id ? 1 : a.id < b.id ? -1 : 0);
  }

  @override
  insert(id, V value) {
    NodeB<V> n = this;
    //TODO: ir o mais fundo da arvore o possível
    insertNode(NodeBElement<V>(id, value));
  }

  @override
  remove(id) {

  }

  NodeB(this.maxDegree){
    if(maxDegree < 1){
      throw "Invalid maxDegree value!";
    }
  }
}