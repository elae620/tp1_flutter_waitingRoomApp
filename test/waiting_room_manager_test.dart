import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:waiting_room_app/main.dart';
import 'package:waiting_room_app/waiting_room_manager.dart';

void main() {
  test('should add a client to the waiting list', () {
    // ARRANGE
    final manager = WaitingRoomManager();

    // ACT
    manager.addClient('John Doe');

    // ASSERT
    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'John Doe');
  });

  test('should remove a client from the waiting list', () {
    // ARRANGE
    final manager = WaitingRoomManager();

    manager.addClient('John Doe');
    manager.addClient('Jane Doe');

    // ACT
    manager.removeClient('John Doe');

    // ASSERT
    expect(manager.clients.length, 1);
    expect(manager.clients.first, 'Jane Doe');
  });

  testWidgets(
    'should remove a client from the list when the delete button is tapped',
    (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(const WaitingRoomApp());

      await tester.enterText(
        find.byType(TextField),
        'Bob',
      );

      await tester.tap(
        find.byType(ElevatedButton),
      );

      await tester.pump();

      // ACT
      await tester.tap(
        find.byIcon(Icons.delete),
      );

      await tester.pump();

      // ASSERT
      expect(find.text('Bob'), findsNothing);
      expect(
        find.text('Clients in Queue: 0'),
        findsOneWidget,
      );
    },
  );
}