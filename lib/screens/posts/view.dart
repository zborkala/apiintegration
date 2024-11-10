import 'package:apiintegration/models/post.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.post.title}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${widget.post.body}", textAlign: TextAlign.justify, style: const TextStyle(fontSize: 16),),
      ),
    );
  }
}