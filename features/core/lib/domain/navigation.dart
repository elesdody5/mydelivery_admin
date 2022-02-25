class Destination<T> {
  String routeName;
  T? argument;
  bool removeFromStack;

  Destination(
      {required this.routeName, this.argument, this.removeFromStack = false});

  @override
  String toString() {
    return 'Navigation{routeName: $routeName, argument: $argument, removeFromStack: $removeFromStack}';
  }
}
