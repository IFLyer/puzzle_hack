import 'dart:math';

enum GameAction { actionUp, actionRight, actionDown, actionLeft }

class Pos {
  final int x;
  final int y;
  Pos(this.x, this.y);
}

class GameManager {
  late List<List<int>> data;
  init() {
    data = List.generate(
        4, (i) => List.generate(4, (j) => i * 4 + j + 1, growable: false),
        growable: false);
  }

  int getEmptyIndex() => getValueIndex(16);

  Pos getEmptyPos() => getValuePos(16);

  int getValueIndex(int value) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (data[i][j] == value) {
          return i * 4 + j + 1;
        }
      }
    }
    return 0;
  }

  Pos getValuePos(int value) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (data[i][j] == value) {
          return Pos(j, i);
        }
      }
    }
    return Pos(0, 0);
  }

  bool canActionUp() {
    var pos = getEmptyPos();
    return pos.y != 3;
  }

  bool canActionRight() {
    var pos = getEmptyPos();
    return pos.x != 0;
  }

  bool canActionDown() {
    var pos = getEmptyPos();
    return pos.y != 0;
  }

  bool canActionLeft() {
    var pos = getEmptyPos();
    return pos.x != 3;
  }

  List<GameAction> listAvailableAction() {
    List<GameAction> list = [];
    if (canActionUp()) {
      list.add(GameAction.actionUp);
    }
    if (canActionRight()) {
      list.add(GameAction.actionRight);
    }
    if (canActionDown()) {
      list.add(GameAction.actionDown);
    }
    if (canActionLeft()) {
      list.add(GameAction.actionLeft);
    }
    return list;
  }

  actionUp() {
    var pos = getEmptyPos();
    data[pos.y][pos.x] = data[pos.y + 1][pos.x];
    data[pos.y + 1][pos.x] = 16;
  }

  actionRight() {
    var pos = getEmptyPos();
    data[pos.y][pos.x] = data[pos.y][pos.x - 1];
    data[pos.y][pos.x - 1] = 16;
  }

  actionDown() {
    var pos = getEmptyPos();
    data[pos.y][pos.x] = data[pos.y - 1][pos.x];
    data[pos.y - 1][pos.x] = 16;
  }

  actionLeft() {
    var pos = getEmptyPos();
    data[pos.y][pos.x] = data[pos.y][pos.x + 1];
    data[pos.y][pos.x + 1] = 16;
  }

  GameAction? getActionByValue(int value) {
    var posValue = getValuePos(value);
    var posEmpty = getEmptyPos();

    if (posValue.x == posEmpty.x) {
      if (posValue.y == posEmpty.y + 1) {
        return GameAction.actionUp;
      }
      if (posValue.y == posEmpty.y - 1) {
        return GameAction.actionDown;
      }
    } else if (posValue.y == posEmpty.y) {
      if (posValue.x == posEmpty.x + 1) {
        return GameAction.actionLeft;
      }
      if (posValue.x == posEmpty.x - 1) {
        return GameAction.actionRight;
      }
    }

    return null;
  }

  shuffle() {
    Random r = Random();
    init();
    for (int i = 0; i < 150; i++) {
      var list = listAvailableAction();
      var action = list[r.nextInt(list.length)];
      doAction(action);
    }
  }

  void doAction(GameAction action) {
    switch (action) {
      case GameAction.actionUp:
        actionUp();
        break;
      case GameAction.actionRight:
        actionRight();
        break;
      case GameAction.actionDown:
        actionDown();
        break;
      case GameAction.actionLeft:
        actionLeft();
        break;
    }
  }

  bool isComplete() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (data[i][j] != i * 4 + j + 1) {
          return false;
        }
      }
    }
    return true;
  }
}
