import 'dart:convert';

import 'package:apiintegration/constants/endpoints.dart';
import 'package:apiintegration/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  GlobalKey<FormState> formKey = GlobalKey();
  Post post = Post(title: '', body: '');

  addPost() async {
    try {
      var response = await http.post(Uri.parse(postsEndPoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(post.toMap()));
      
      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Post added successfully!")));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error adding post $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Title", border: OutlineInputBorder()),
                  onSaved: (v) {
                    if (v != null) {
                      post.title = v;
                    }
                  },
                  validator: (v) {
                     if (v == null || v.isEmpty) {
                      return "Title cannot be empty";
                     }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Content", border: OutlineInputBorder()),
                  onSaved: (v) {
                    if (v != null && v.isNotEmpty) {
                      post.body = v;
                    }
                  },
                  validator: (v) {
                     if (v == null || v.isEmpty) {
                      return "Content cannot be empty";
                     }
                  },
                  maxLines: null,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        addPost();
                      }
                    },
                    child: const Text("Add Post")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
