import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_hack/game_manager.dart';

void main() {
  late GameManager manager;
  setUp(() {
    manager = GameManager();
  });
  test('Game Manager init', () {
    manager.init();
    expect(manager.isComplete(), true);
  });
  test('Game Manager action right', () {
    manager.init();
    expect(manager.canActionRight(), true);
    manager.actionRight();
    expect(manager.getEmptyIndex(), 15);
    expect(manager.isComplete(), false);
    manager.actionRight();
    manager.actionRight();
    expect(manager.canActionRight(), false);
  });

  test('Game Manager action down', () {
    manager.init();
    expect(manager.canActionDown(), true);
    manager.actionDown();
    expect(manager.getEmptyIndex(), 12);
    expect(manager.isComplete(), false);
    manager.actionDown();
    manager.actionDown();
    expect(manager.canActionDown(), false);
  });

  test('Game Manager action left', () {
    manager.init();
    expect(manager.canActionLeft(), false);
    manager.actionRight();
    expect(manager.canActionLeft(), true);
    manager.actionLeft();
    expect(manager.isComplete(), true);
  });

  test('Game Manager action up', () {
    manager.init();
    expect(manager.canActionUp(), false);
    manager.actionDown();
    expect(manager.canActionUp(), true);
    manager.actionUp();
    expect(manager.isComplete(), true);
  });
}
