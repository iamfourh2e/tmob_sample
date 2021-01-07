import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:sample/bloc/post_model.dart';

class HomeBLoC {
  HomeBLoC() {
    getPostResult();
  }
  List<Post> posts = [];
  var subjectPostList = BehaviorSubject<List<Post>>();

  dispose() {
    subjectPostList.close();
  }

  getPostResult() {
    fetchPosts().then((value) {
      posts = List<Post>.from(value.map((json) => Post.fromJson(json)));
      subjectPostList.add(posts);
    });
  }

  Future fetchPosts() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';

    return await http
        .get(url)
        .then((http.Response response) => jsonDecode(response.body))
        .catchError((err) => err);
  }
}
