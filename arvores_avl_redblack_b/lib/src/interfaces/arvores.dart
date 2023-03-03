/// Base das arvores
abstract class Arvore<V>{
  insert(id, V value);
  remove(id);
  V? find(id);
}