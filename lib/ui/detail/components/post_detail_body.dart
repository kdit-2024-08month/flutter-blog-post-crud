import 'package:blog/ui/detail/post_detail_vm.dart';
import 'package:blog/ui/list/post_list_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PostDetailBody extends ConsumerWidget {
  int id;
  PostDetailBody(this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostDetailModel? model = ref.watch(postDetailProvider(id));

    if (model == null) {
      return LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.redAccent,
        size: 200,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Icon(CupertinoIcons.trash_fill),
                onPressed: () {
                  ref.read(postListProvider.notifier).notifyDelete(model.id);
                },
              ),
            ),
            SizedBox(height: 10),
            Text("id : ${model.id}", style: TextStyle(fontSize: 20)),
            Text("title : ${model.title}"),
            Text("content : ${model.content}"),
            Text("createdAt : ${model.createdAt}"),
            Text("updatedAt : ${model.updatedAt}"),
          ],
        ),
      );
    }
  }
}
