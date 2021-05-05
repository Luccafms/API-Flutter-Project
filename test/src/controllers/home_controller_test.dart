import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sync_async/src/controllers/home_controller.dart';
import 'package:sync_async/src/models/todo_model.dart';
import 'package:sync_async/src/repositories/todo_repository.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {} 

main() {

  final repository = TodoRepositoryMock();

  final controller = HomeController(repository);

  test('deve preencher variavel todos', () async {
    when(repository.fetchTodos()).thenAnswer((_) async => [TodoModel()]);
    expect(controller.state, HomeState.start);
    await controller.start();
    expect(controller.state, HomeState.success);
    expect(controller.todos.isNotEmpty, true);
  });
  test('deve modificar o estado para error se a requisição falhar', () async {
    when(repository.fetchTodos()).thenThrow(Exception());
    expect(controller.state, HomeState.start);
    await controller.start();
    expect(controller.state, HomeState.error);
  });
}