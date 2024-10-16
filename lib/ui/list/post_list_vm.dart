import 'package:blog/core/utils.dart';
import 'package:blog/data/post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListVM extends StateNotifier<PostListModel?> {
  final mContext = navigatorKey.currentState!.context;

  PostListVM(super.state);

  Future<void> notifyDelete(int id) async {
    await PostRepository().deleteById(id);
    PostListModel model = state!;

    // PostListModel의 메서드를 통해 포스트 삭제
    state = model.removePostById(id);

    Navigator.pop(mContext);
  }

  // 트랜잭션
  Future<void> notifySave(String title, String content) async {
    var one = await PostRepository().save(title, content);
    PostListModel model = state!;

    // PostListModel의 메서드를 통해 새로운 포스트 추가
    state = model.addNewPost(one);

    Navigator.pop(mContext);
  }

  Future<void> notifyInit() async {
    var list = await PostRepository().findAll();

    // 초기 상태 갱신
    state = PostListModel.fromList(list);
  }
}

class PostListModel {
  List<({int id, String title})> posts;

  PostListModel(this.posts);

  PostListModel.fromList(list)
      : posts = list
            .map((e) => (id: e["id"] as int, title: e["title"] as String))
            .toList();

  static ({int id, String title}) fromMap(map) {
    return (id: map["id"], title: map["title"]);
  }

  // 포스트 추가 메서드
  PostListModel addNewPost(map) {
    var post = fromMap(map);
    var newPosts = [post, ...posts];
    return PostListModel(newPosts);
  }

  // 포스트 삭제 메서드
  PostListModel removePostById(int id) {
    var filteredPosts = posts.where((post) => post.id != id).toList();
    return PostListModel(filteredPosts);
  }
}

final postListProvider =
    StateNotifierProvider<PostListVM, PostListModel?>((ref) {
  return PostListVM(null)..notifyInit();
});
