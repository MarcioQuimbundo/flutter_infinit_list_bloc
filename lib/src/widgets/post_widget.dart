import 'package:flutter/material.dart';
import 'package:flutter_infinit_list_bloc/src/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text(
          '${post.id}',
          style: TextStyle(fontSize: 10.0),
        ),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
