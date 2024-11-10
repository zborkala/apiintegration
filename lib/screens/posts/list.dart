import 'dart:convert';

import 'package:apiintegration/constants/endpoints.dart';
import 'package:apiintegration/models/post.dart';
import 'package:apiintegration/screens/posts/add.dart';
import 'package:apiintegration/screens/posts/view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  Future<List<Post>> retrievePosts() async {
    List<Post> posts = [];
    try {
      var response = await http
          .get(Uri.parse(postsEndPoint));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (Map map in data) {
          posts.add(Post.fromJson(map));
        }
      }
      return posts;
    } catch (e) {
      return posts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const AddPost()));
          }, icon: const Icon(Icons.add_circle))
        ],
      ),
      body: FutureBuilder(
          future: retrievePosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => PostView(post: posts[i])));
                      },
                      leading: Text("${posts[i].id}"),
                      title: Text("${posts[i].title}"),
                    );
                  });
            } else {
              return const Center(
                child: Text("No Data"),
              );
            }
          }),
    );
  }
}
