import 'package:arvores_avl_redblack_b/src/b/node_b.dart';
import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';
import 'package:arvores_avl_redblack_b/src/interfaces/tree.dart';
import 'package:arvores_avl_redblack_b/src/interfaces/wrapper.dart';

class TreeB<V> extends Tree<V>{

  final int t;
  late final int minDegree, maxDegree, _middleI;

  NodeB<V>? _root;

  int _lenght = 0;

  int get lenght => _lenght;

  TreeB(this.t){
    if(t < 1){
      throw "Invalid order!";
    }
    maxDegree = 2 * t - 1;
    minDegree = t - 1;
    int mm = (maxDegree / 2).floor();
    if(maxDegree % 2 != 0){
      mm++;
    }
    _middleI = mm;
  }

  NodeB<V>? _getChild(int id, NodeB<V>? no, bool isRight){
    int pos = no != null ? no.getElementPosition(id) : -1;
    if(pos < 0){
      return null;
    }
    return no!.getChildAt(isRight ? pos + 1 : pos);           
  }  

  NodeB<V> _getBiggerChildThatMin(int id, NodeB<V> no, Wrapper<int> nodeDownLevel){
    nodeDownLevel.v = 1;
    Wrapper<int> leftLevel = Wrapper(0);

    NodeB<V>? child = _getChild(id, no, false);
    NodeB<V>? righterChild = getChildRighter(child, leftLevel);

    nodeDownLevel.v += leftLevel.v;

    if(righterChild != null && righterChild.lenght > _middleI - 1){       
      return righterChild;
    }
    
    Wrapper<int> rightLevel = Wrapper(0);
    child = _getChild(id, no, true);
    NodeB<V>? lefterChild = getChildLefter(child, rightLevel);
    
    if(lefterChild != null && lefterChild.lenght > _middleI - 1){
      nodeDownLevel.v += rightLevel.v;
      return lefterChild;
    }
    
    return righterChild!;
  }

  NodeB<V>? getChildLefter(NodeB<V>? child, Wrapper<int> rightLevel){
    //TODO:
  }

  NodeB<V>? getChildRighter(NodeB<V>? child, Wrapper<int> leftLevel){
    //TODO:
  }

  NodeB<V>? _getBiggerBrotherThanMin(NodeB<V> no){
    //TODO:
  }

  NodeB<V>? _getNodeToInsertNewElement(id, int stopLevel,  Wrapper<int> nodeLevel){
      nodeLevel.v = 1;
      
      NodeB<V>? noAux = _root;
      
      while(noAux != null){
          if((stopLevel == nodeLevel.v) || noAux.isSheet) {
            return noAux;
          }   
          noAux = noAux.getNextNodeToElement(id);
          nodeLevel.v++;
      }

      return null; 
  }

  @override
  V? find(id) {
    if(_root == null){
      return null;
    }
    return _search(id)?.get(id);
  }

  NodeB<V>? _search(id, {Wrapper<int>? nodeLevel}){     
    nodeLevel ??= Wrapper<int>(1);
    NodeB<V>? noAux = _root;
    
    while(noAux != null){

      if(noAux.contains(id)){
          break;
      }
      
      noAux = noAux.getNextNodeToElement(id);

      nodeLevel.v++;
    }
      
    return noAux;
  }

  @override
  bool insert(id, V value) {
    Wrapper<int> nodeLevel = Wrapper(-1);
    
    NodeB<V>? n = _root == null ? null : _search(id, nodeLevel: nodeLevel);
    
    if(n != null){
      return false;
    }

    n = _root == null ? null : _getNodeToInsertNewElement(id, -1, nodeLevel);   
    
    _lenght++;
    
    _insert(NodeBElement(id, value), n, nodeLevel.v, null, null);
    
    return true;
  }

  _insert(NodeBElement<V> element, NodeB<V>? no, int nodeLevel, NodeB<V>? left, NodeB<V>? right){
    if(_root == null){  
      _root = NodeB.empty(t, nodeLevel == -1);
      
      _root!.insert(element);
      
      if(left != null && right != null){
        _root!.insertChild(left, 0);
        _root!.insertChild(right, 1);
        
        left.parent = _root;
        right.parent = _root;
      }
    }else{
      int pos = no!.insert(element);
      
      if(right != null){
          right.parent = no;
          no.insertChild(right, pos + 1);
      }
      
      if(no.lenght > maxDegree){
        int oldL = no.lenght;
        List<NodeB<V>>? newChildren = no.splitChildren();
        List<NodeBElement<V>> newElements = no.splitElementas();
        int newNumberOfKeys = oldL - no.lenght;
            
        NodeB<V> newNode = NodeB.empty(t, no.isSheet);
      	   
        newNode.right = no.right;
        newNode.left = no;
        
        if(no.right != null){
          no.right!.left = newNode;
        }
        
        no.right = newNode;	
        
        for(int i = 0; i < newNumberOfKeys; i++){
          newNode.insertElement(newElements[i]);
        }
      
        if(newChildren != null){
          for(int i = 0; i < newChildren.length; i++){  
              NodeB<V> f = newChildren[i];
              f.parent = newNode;
              newNode.insertChild(f, i);
          }
        }
          
        NodeBElement<V> elementPromoted = no.removeLastElement()!;
        
        left = no == _root ? no : null;
        right = newNode;
        
        if(no == _root){
            _root = null;
            no = null;
        }else{
            no = no.parent;
        }

        _insert(elementPromoted, no, nodeLevel - 1, left, right);
      }
    }
  }

  @override
  bool remove(id) {
    if(_root == null){
      return false;
    }
    Wrapper<int> nodeLevel = Wrapper(0);
    NodeB<V>? no = _search(id, nodeLevel: nodeLevel);

    if(no == null){
      return false;
    }

    _lenght--;
    _remove(id, no, nodeLevel.v, -1);
    
    return true;
  }

  _redistributeElements(NodeB<V> no, NodeB<V> parent, NodeB<V> brother, int id, bool isStopLevel){
    //TODO:
  }

  _combinateNodes(NodeB<V> no1, NodeB<V> no2, int id, int nodeLevel){
    //TODO:
  }

  _remove(int id, NodeB<V> no, int nodeLevel, int stopLevel){
    if(no.isSheet || nodeLevel == stopLevel){
      NodeB<V>? parent = no.parent;
      no.removeElement(id);
      if(no.lenght < _middleI - 1){
        NodeB<V>? brother = _getBiggerBrotherThanMin(no);
        if(brother != null){
          _redistributeElements(no, parent!, brother, id, nodeLevel == stopLevel);
        }else if(parent != null){
          _combinateNodes(no, parent, id, nodeLevel);
        }else if(no.lenght == 0){
          _root = null;
        }
      }
    }else{
      _romoveCopying(no, id, nodeLevel);
    }
  }

  _romoveCopying(NodeB<V> no, int id, int nodeLevel){
    Wrapper<int> nodeDownLevel = Wrapper(0);
    NodeB<V> child = _getBiggerChildThatMin(id, no, nodeDownLevel);

    nodeLevel += nodeDownLevel.v;
    NodeBElement<V> promotedElement = (id <= child.getElementAt(0)!.id)
      ? child.getElementAt(0)!
      : child.getElementAt(child.lenght - 1)!;
    no.replaceElementAt(promotedElement, no.getElementPosition(id));

    _remove(promotedElement.id, child, nodeLevel, -1);
  }
}