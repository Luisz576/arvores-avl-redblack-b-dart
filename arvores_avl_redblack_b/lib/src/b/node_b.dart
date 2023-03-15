import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';

class NodeB<V>{
  List<dynamic> get callElements{
    List<dynamic> view = [];

    for(int i = 0; i < maxDegree + 1; i++){
      view.add(_elements[i] ?? 0);
    }

    return view;
  }

  List<dynamic> get callChildren{
    List<dynamic> view = [];

    for(int i = 0; i < maxDegree + 2; i++){
      view.add(_children[i] ?? 0);
    }

    return view;
  }

  final int t;
  late final int maxDegree, _middleI;

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

  V? get(id){
    for(int i = 0; i < lenght; i++){
      if(_elements[i]!.id == id){
          return _elements[i]!.value;
      }
    }
    return null;
  }

  int getPositionToNewElement(int id){  
    for(int i = 0; i < _lenght; i++){
      if(id < _elements[i]!.id){
        return i;
      }
    }
    return _lenght;
  }

  V? getElementThatNextNodeToElement(id){
    if(isSheet){
      return null;
    }
    
    for(int i = 0; i < lenght; i++){
      if(id < _elements[i]!.id){
        return _elements[i]!.value;
      }
    }       
    
    return _elements[lenght - 1]!.value;
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

  int getElementPosition(int id){
    for(int i = 0; i < _lenght; i++){
      if(id == _elements[i]!.id){
        return i;
      }
    }
    return -1;
  }

  NodeBElement<V>? removeLastElement(){                  
    return removeElementAt(lenght - 1);
  }

  NodeB<V>? removeLastChild(){                  
    return removeChildAt(lenght);
  }

  NodeB<V>? removeChildAt(int pos){  
    if(!isSheet && pos >= 0 && pos < lenght + 1){
      NodeB<V> p = _children[pos]!;
      if(pos > 0){
        _children[pos - 1]!.right = p.right;
      }
      if(pos < lenght){
        _children[pos + 1]!.left = p.left;
      }

      p.parent = null;
      p.left = null;
      p.right = null;

      for(int i = pos; i < lenght; i++){
        _children[i] = _children[i + 1];
      }
      
      _children[lenght] = null;
      
      return p;
    }
    return null;
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

  int removeElement(id){
    int pos = _getElementPosition(id);
    if(pos == -1){
      return -1;
    }
    removeElementAt(pos);
    return pos;
  }

  insertElement(NodeBElement<V> element){
    int pos = _getPositionToNewElement(element.id);
    _insertNewElementAt(element, pos);
    return pos;
  }

  insertChild(NodeB<V>? child, int pos){
    if(child == null || pos < 0 || pos > maxDegree + 1){
      return;
    }
    NodeB<V>? p = pos > 0 ? _children[pos - 1] : null;
    child.left = p; 
    
    if(p != null){
      p.right = child;
    }
    
    p = pos < _lenght + 1 ? _children[pos] : null;
    child.right = p;
    
    if(p != null){
      p.left = child;
    }

    for(int i = _lenght; i > pos; i--){
        _children[i] = _children[i - 1]; 
    }

    _children[pos] = child;     
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

  List<NodeBElement<V>> splitElementas(){
    List<NodeBElement<V>> elementsSeparated = [];
    
    for(int i = _middleI; i < _lenght; i++){
        elementsSeparated.add(_elements[i]!);
        _elements[i] = null;
    }
    
    _lenght = _middleI;
    
    return elementsSeparated;
  }

  List<NodeB<V>>? splitChildren(){
    if(isSheet){
      return null;
    }
    
    List<NodeB<V>>? childrenSepareted = [];
    
    _children[_middleI]!.left = null;
    
    for(int i = _middleI; i < _lenght + 1; i++){
      childrenSepareted.add(_children[i]!);
      childrenSepareted[i - _middleI].parent = null;
      _children[i] = null; 
    }
    
    _children[_middleI - 1]!.right = null;
    
    return childrenSepareted;
  }

  replaceElementAt(NodeBElement<V> element, int pos){
    if(pos >= 0 && pos < _lenght){
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
    int mm = (maxDegree / 2).floor();
    if(maxDegree % 2 != 0){
      mm++;
    }
    _middleI = mm;
    for(int i = 0; i < maxDegree + 2; i++){
      _children.add(null);
      if(i < maxDegree + 1){
        _elements.add(null);
      }
    }
  }
}