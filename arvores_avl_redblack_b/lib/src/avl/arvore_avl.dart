import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreAVL<V> extends Arvore<V>{
  NodeAVL<V>? _root;

  @override
  insert(id, V value){
    if(_root == null){
      _root = NodeAVL(id, value, null);
      return;
    }
    NodeAVL<V> node = _root!;
    while(true){
      if(id < node.id){
        if(node.left == null){
          node.left = NodeAVL(id, value, node);
          node = node.left!;
          break;
        }
        node = node.left!;
        continue;
      }
      if(node.right == null){
        node.right = NodeAVL(id, value, node);
        node = node.right!;
        break;
      }
      node = node.right!;
    }
    _verifyAndBalance(node.parent);
  }

  _verifyAndBalance(NodeAVL<V>? node){
    while(node != null){
      node = node.parent;
      if(node == null){
        return;
      }
      if(node.weight > 1){
        if(node.right!.weight < 0){
          node = _doDoubleRotation(node, true);
          continue;
        }
        _doRotation(node, false);
        continue;
      }
      if(node.weight < -1){
        if(node.left!.weight > 0){
          node = _doDoubleRotation(node, false);
          continue;
        }
        _doRotation(node, true);
      }
    }
  }

  NodeAVL<V> _doDoubleRotation(NodeAVL<V> node, toLeftFirst){
    _doRotation(toLeftFirst ? node.right!: node.left!, toLeftFirst);
    _doRotation(node, !toLeftFirst);
    return node;
  }

  _doRotation(NodeAVL<V> node, toLeft){
    if(toLeft){
      NodeAVL<V> leftNode = node.left!;
      if(_root == node){
        _root = leftNode;
      }
      leftNode.parent = node.parent;
      if(node.parent != null){
        if(node.parent!.left == node){
          node.parent!.left = leftNode;
        }else{
          node.parent!.right = leftNode;
        }
      }
      node.left = leftNode.right;
      node.parent = leftNode;
      leftNode.right = node;
      return;
    }
    NodeAVL<V> rightNode = node.right!;
    if(_root == node){
      _root = rightNode;
    }
    rightNode.parent = node.parent;
    if(node.parent != null){
      if(node.parent!.left == node){
        node.parent!.left = rightNode;
      }else{
        node.parent!.right = rightNode;
      }
    }
    node.right = rightNode.left;
    node.parent = rightNode;
    rightNode.left = node;
  }

  @override
  remove(id){
    
  }

  @override
  V? find(id){
    NodeAVL? node = _root;
    while(node != null){
      if(id == node.id){
        return node.value;
      }
      if(id < node.id){
        node = node.left;
        continue;
      }
      node = node.right;
    }
    return null;
  }
}