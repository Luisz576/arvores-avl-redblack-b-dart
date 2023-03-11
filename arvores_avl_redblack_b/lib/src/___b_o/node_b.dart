import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';
import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';

class NodeB<V> extends Arvore<V>{
  final NodeBElement<V> _empty = NodeBElement.empty();

  final int maxDegree, minDegree;
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

      NodeB<V> rightNode = NodeB<V>(maxDegree, minDegree);
      while(_elements.length > middle){
        rightNode.insertNode(_elements.removeAt(middle));
      }
      rightNode.rightChild = rightToRight;
      rightNode.sort();
      
      parent ??= NodeB<V>(maxDegree, minDegree);

      rightNode.parent = parent;
      parent!.insertNodeWithRight(element, rightNode);
    }
  }

  sort(){
    _elements.sort((a, b) => a.id > b.id ? 1 : a.id < b.id ? -1 : 0);
  }

  NodeB<V> getNextNodeOrSelf(id){
    return _elements.firstWhere((element) => element.id > id, orElse: () => _empty).leftChild ?? rightChild ?? this;
  }

  @override
  insert(id, V value) {
    NodeB<V> n = this;
    NodeB<V> oldN;

    do{
      oldN = n;
      n = n.getNextNodeOrSelf(id);
    }while(oldN != n);

    n.insertNode(NodeBElement<V>(id, value));
  }

  NodeBElement<V>? removeLastElement(){
    return _elements.isNotEmpty ? _elements.removeAt(_elements.length - 1) : null;
  }

  @override
  remove(id) {
    if(contains(id)){
      NodeBElement<V> element = _elements.firstWhere((element) => element.id == id);
      _elements.remove(element);
      if(_elements.length < minDegree){
        if(element.leftChild == null){
          //TODO: Pega emprestado (olha irmão da direita primeiro) (tem q poder doar, senão, faz fusão (ver da direita dps esquerda))
          return;
        }
        _elements.add(element.leftChild!.removeLastElement()!);
        sort();
        if(element.leftChild!.lenght < minDegree){
          if(){
            
          }
          return;
        }
        return true;
      }
      return true;
    }
    NodeB<V>? next = _elements.firstWhere((element) => element.id > id, orElse: () => _empty).leftChild;
    next ??= rightChild;
    if(next == null){
      return false;
    }
    return next.remove(id);
  }

  NodeB(this.maxDegree, this.minDegree){
    if(maxDegree < 1){
      throw "Invalid maxDegree value!";
    }
    if(minDegree < 0){
      throw "Invalid minDegree value!";
    }
  }
}