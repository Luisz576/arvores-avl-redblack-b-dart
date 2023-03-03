import 'package:arvores_avl_redblack_b/arvores_avl_redblack_b.dart';

class ArvoreAVL<V> extends Arvore<V>{
  NodeAVL? _root;

  @override
  insert(id, V value){
    NodeAVL? node = _root;
    while(node != null){
      if(id < node.id){
        if(node.left == null){
          node.left = NodeAVL(id, value, node);
          node = node.left;
          break;
        }
        node = node.left;
        continue;
      }
      if(node.right == null){
        node.right = NodeAVL(id, value, node);
        node = node.right;
        break;
      }
      node = node.right;
    }
    if(node == null){
      _root = NodeAVL(id, value, null);
      return;
    }
    _verifyAndBalanceIfItNeeds(node);
  }

  _verifyAndBalanceIfItNeeds(NodeAVL? addedNode){
    if(addedNode == null) return;
    NodeAVL? node = addedNode;
    while(node != null){
      NodeAVL? parent = node.parent;
      if(parent == null){
        return;
      }
      if(parent.weight > 1
        || parent.weight < -1){
          _balanceIt(parent);
        }
      node = parent;
    }
  }

  _balanceIt(NodeAVL node){
    //TODO: balance
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