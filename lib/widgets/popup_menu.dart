import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  const PopupMenu({
    super.key,
    required this.task,
    required this.cancelOrDeleteCallBack,
    required this.likeOrDislike,
    required this.editTaskCallBack,
    required this.restoreTaskCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: (){},
                  child: TextButton.icon(
                    onPressed: editTaskCallBack,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                   onTap: likeOrDislike,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavourite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_add),
                    label: task.isFavourite == false
                        ? const Text('Add To\n Bookmark')
                        : const Text('Remove From \nBookmark'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallBack,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallBack,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallBack,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                ),
              ],
    );
  }
}
