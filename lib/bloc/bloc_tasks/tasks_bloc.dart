import 'package:equatable/equatable.dart';

import '../../models/task.dart';
import '../bloc_exports.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTasks);
    on<UpdateTask>(_onUpdateTasks);
    on<DeleteTask>(_onDeleteTasks);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavouriteOrUnfavouriteEvent>(_onMarkFavouriteOrUnfavouriteTask);
    on<EditTaskEvent>(_onEditTask);
    on<RestoreTaskEvent>(_onRestoreTask);
    on<DeleteAllTaskEvent>(_onDeketeAllTasks);
  }
  void _onAddTasks(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTasks(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    if (task.isDone == false) {
      if (task.isFavourite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavourite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTasks(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(task),
      completedTasks: List.from(state.completedTasks)..remove(task),
      favouriteTasks: List.from(state.favouriteTasks)..remove(task),
      removedTasks: List.from(state.removedTasks)
        ..add(task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavouriteOrUnfavouriteTask(
      MarkFavouriteOrUnfavouriteEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.oldTask.isFavourite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.oldTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
            0,
            event.task
                .copyWith(isDeleted: false, isDone: false, isFavourite: false),
          ),
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
      ),
    );
  }

  void _onDeketeAllTasks(DeleteAllTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..clear(),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
      pendingTasks: state.pendingTasks,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}


//  void _onUpdateTasks(UpdateTask event, Emitter<TasksState> emit) {
//     final state = this.state;
//     final task = event.task;

//     List<Task> pendingTasks = state.pendingTasks;
//     List<Task> completedTasks = state.completedTasks;
//     task.isDone == false
//         ? {
//             pendingTasks = List.from(pendingTasks)..remove(task),
//             completedTasks = List.from(completedTasks)
//               ..insert(0, task.copyWith(isDone: true))
//           }
//         : {
//             completedTasks = List.from(completedTasks)..remove(task),
//             pendingTasks = List.from(pendingTasks)
//               ..insert(0, task.copyWith(isDone: false))
//           };
//     emit(
//       TasksState(
//         pendingTasks: pendingTasks,
//         completedTasks: completedTasks,
//         favouriteTasks: state.favouriteTasks,
//         removedTasks: state.removedTasks,
//       ),
//     );
//   }