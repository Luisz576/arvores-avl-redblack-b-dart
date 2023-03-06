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
    _verifyAndBalanceIfItNeeds(node);
  }

  _verifyAndBalanceIfItNeeds(NodeAVL<V> addedNode){
    NodeAVL<V> node = addedNode;
    while(true){
      NodeAVL<V>? parent = node.parent;
      if(parent == null){
        return;
      }
      node = parent;
      if(parent.weight > 1){
        _balanceIt(parent, false);
        continue;
      }
      if(parent.weight < -1){
        _balanceIt(parent, true);
        continue;
      }
    }
  }

  _balanceIt(NodeAVL<V> node, bool balanceToLeft){
    if(balanceToLeft){
      NodeAVL<V> rightNode = node.right!;
      if(node.parent == null){
        _root = rightNode;
        rightNode.parent = null;
        rightNode.left = node;
        node.parent = rightNode;
        node.right = rightNode.left;
        return;
      }
      rightNode.parent = node.parent;
      if(node.parent!.left == node){
        node.parent!.left = rightNode;
      }else{
        node.parent!.right = rightNode;
      }
      node.parent = rightNode;
      node.right = rightNode.left;
      rightNode.left = node;
      return;
    }
    NodeAVL<V> leftNode = node.left!; //TODO: ajustar
    if(node.parent == null){
      _root = leftNode;
      leftNode.parent = null;
      leftNode.right = node;
      node.parent = leftNode;
      node.left = leftNode.right;
      return;
    }
    leftNode.parent = node.parent;
    if(node.parent!.left == node){
      node.parent!.left = leftNode;
    }else{
      node.parent!.right = leftNode;
    }
    node.parent = leftNode;
    node.left = leftNode.right;
    leftNode.right = node;
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