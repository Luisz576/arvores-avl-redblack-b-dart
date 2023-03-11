import 'package:arvores_avl_redblack_b/src/b/node_b.dart';
import 'package:arvores_avl_redblack_b/src/b/node_b_element.dart';
import 'package:arvores_avl_redblack_b/src/interfaces/arvores.dart';
import 'package:arvores_avl_redblack_b/src/interfaces/wrapper.dart';

class ArvoreB<V> extends Arvore<V>{
  final int t;
  late final int minDegree, maxDegree;

  NodeB<V>? _root;

  int _lenght = 0;

  int get lenght => _lenght;

  ArvoreB(this.t){
    if(t < 1){
      throw "Invalid order!";
    }
    maxDegree = 2 * t - 1;
    minDegree = t - 1;
  }

  NodeB<V>? _getNodeToInsertNewElement(id, Wrapper<int> nodeLevel){
      nodeLevel.v = 1;
      
      NodeB<V>? noAux = _root;
      
      while(noAux != null){
          if(noAux.isSheet) {
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
        
    n = _root == null ? null : _getNodeToInsertNewElement(id, nodeLevel);   
    
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
          right->setAscendente(no);
          no.insertChild(right, pos + 1);
      }
      
      if(no.lenght > maxDegree){

        List<NodeB<V>>? novosFilhos = no.splitChildren(); 
        List<NodeBElement<V>> novasChaves = no.splitElementas(); 
        int newNumberOfKeys = maxDegree - no.lenght;
            
        NodeB<V> novoNo = NodeB.empty(maxDegree, no.isSheet);
      	   
        novoNo.right = no.right;
        novoNo.left = no;
        
        if(no.right != null){
          no.right!.left = novoNo;
        }
        
        no.right = novoNo;	
        
        for(int i = 0; i < newNumberOfKeys; i++){
          novoNo.insertElement(novasChaves[i]); //TODO: criar insertElement para nã oduplicar classe
        }
                
        novasChaves.clear();
      
        if(novosFilhos != null){
          for(int i=0; i < newNumberOfKeys + 1; i++){  
              NodeB<V> f = novosFilhos[i];        
              f->setAscendente(novoNo);
              novoNo.insertChild(f, i);
          }
          novosFilhos.clear();
        }
          
      
        NodeBElement<V> chavePromovida = no.removeLastElement()!;                       
        
        left = no == _root ? no : null; 
        right = novoNo;              
        
        if(no == _root){
            _root = null;
            no = null;
        }else{
            no = no->getAscendente();
        }

        _insert(chavePromovida, no, nodeLevel - 1, left, right);
      }
    }
  }

  @override
  remove(id) {
    if(_root == null){
      return false;
    }
    //TODO:
  }
}