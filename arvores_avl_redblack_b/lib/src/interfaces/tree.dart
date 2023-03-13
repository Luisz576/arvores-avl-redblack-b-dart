/// Base das arvores
abstract class Tree<V>{
  insert(id, V value);
  remove(id);
  V? find(id);
}