import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';

class NodeB<V>{

  final int t;
  late final int maxDegree, minDegree;

  final bool isSheet;

  NodeB<V>? parent, left, right;

  final List<NodeBElement<V>?> _elements = [];
  final List<NodeB<V>?> _children = [];

  int _lenght = 0;

  int get lenght => _lenght;

  NodeB<V>? getChildAt(index){
    if(index >= 0 && index < lenght + 1){
      return _children[index];
    }
    return null;
  }

  NodeBElement<V>? getElementAt(index){
    if(index >= 0 && index < lenght){
      return _elements[index];
    }
    return null;
  }

  int _getPositionToNewElement(id){
    for(int i = 0; i < lenght; i++){
        if(id < _elements[i]!.id){
            return i;
        }
    }
    return lenght;
  }

  int _getElementPosition(id){
    for(int i = 0; i < lenght; i++){
        if(id == _elements[i]!.id){
            return i;
        }
    }
    return -1;
  }

  bool contains(id){
    for(int i = 0; i < lenght; i++){
        if(_elements[i]!.id == id){
            return true;
        }
    }
    return false;
  }

  NodeB<V>? getNextNodeToElement(id){
    if(isSheet){
        return null;
    }
    
    for(int i = 0; i < lenght; i++){
        if(id < _elements[i]!.id){
            return _children[i];   
        }
    }       
    
    return _children[lenght];
  }

  remove(){

  }

  NodeBElement<V>? removeElementAt(int index){  
    if(index >= 0 && index < lenght){
        NodeBElement<V> element = _elements[index]!;
        
        for(int i = index; i < lenght - 1; i++) {
          _elements[i] = _elements[i + 1];
        }
        
        _elements[lenght - 1] = null;
        
        _lenght--;
        
        return element;
    }
    
    return null;
  }


  NodeBElement<V>? removeLastElement(){                  
    return removeElementAt(lenght - 1);
  }

  int removeElement(id){
    int pos = _getElementPosition(id); 
    
    if(pos == -1){
      return -1;
    }

    removeElementAt(pos);
    
    return pos;
  }

  insertChild(NodeB<V> child, int pos){

  }

  int insert(NodeBElement<V> element){
    int pos = _getPositionToNewElement(element.id); 
    
    _insertNewElementAt(element, pos);
    
    return pos;
  }

  _insertNewElementAt(NodeBElement<V> element, pos){
    if(pos >= 0 && pos <= maxDegree){
        _lenght++;
        for(int i = (lenght - 1); i > pos; i--){
            _elements[i] = _elements[i - 1];
        }
        _elements[pos] = element;
    }
  }

  _destroy(){
    parent = null;
    left = null;
    right = null;
    _children.clear();
    _elements.clear();
  }

  NodeB.empty(this.t, this.isSheet){
    maxDegree = 2 * t - 1;
    minDegree = t - 1;
    for(int i = 0; i < maxDegree + 1; i++){
      _children.add(null);
      if(i < maxDegree){
        _elements.add(null);
      }
    }
  }
}