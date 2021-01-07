import 'package:flutter/material.dart';
import 'package:sample/bloc/home_bloc.dart';

import 'bloc/post_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBLoC homeBLoC;

  @override
  void initState() {
    super.initState();
    homeBLoC = HomeBLoC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StreamBuilder(
            initialData: [],
            stream: homeBLoC.subjectPostList,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              var data = snapshot.data;
              return SliverList(
                delegate: SliverChildListDelegate(
                    List.generate(data.length, (index) {
                      Post post = data[index];
                      return ListTile(
                        title: Text("${post.title}"),
                        subtitle: Text("${post.body}"),
                      );
                    })
                ),
              );
            },)
        ],
      ),
    );
  }
}
