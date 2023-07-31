// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  bool? isFavourite;
  bool? isDone;
  bool? isDeleted;
  Task({
    required this.id,
    required this.description,
    required this.title,
    required this.date,
    this.isFavourite,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavourite = isFavourite ?? false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isFavourite': isFavourite,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      isFavourite:
          map['isFavourite'] != null ? map['isFavourite'] as bool : null,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isFavourite,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isFavourite: isFavourite ?? this.isFavourite,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        isFavourite,
        isDone,
        isDeleted,
      ];
}
