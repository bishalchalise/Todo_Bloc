// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final Task task;
  const UpdateTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class RemoveTask extends TasksEvent {
  final Task task;
  const RemoveTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class MarkFavouriteOrUnfavouriteEvent extends TasksEvent {
  final Task task;
  const MarkFavouriteOrUnfavouriteEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class EditTaskEvent extends TasksEvent {
  final Task oldTask;
  final Task newTask;
  const EditTaskEvent({required this.oldTask, required this.newTask});

  @override
  List<Object> get props => [oldTask, newTask];
}

class RestoreTaskEvent extends TasksEvent {
  final Task task;
  const RestoreTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}
class DeleteAllTaskEvent extends TasksEvent{
}
