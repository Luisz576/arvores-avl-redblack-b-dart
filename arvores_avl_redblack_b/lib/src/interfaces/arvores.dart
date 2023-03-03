/// Base das arvores
abstract class Arvore{
  insert(int value);
  remove(int value);
  /// arvore.foreach((value, index){...});
  foreach(Function(int) consumer);
}