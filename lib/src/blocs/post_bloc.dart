import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_infinit_list_bloc/src/blocs/bloc.dart';
import 'package:flutter_infinit_list_bloc/src/models/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostState currentState, PostEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : PostLoaded(
              posts: currentState.posts + posts, hasReachedMax: false
            );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) => state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final respose = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (respose.statusCode == 200) {
      final data = json.decode(respose.body) as List;
      return data.map((rawpost) {
        return Post(
          id: rawpost['id'],
          title: rawpost['title'],
          body: rawpost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
    
  }
}