import 'package:flutter/material.dart';
import 'package:news/models/post.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            title: Text(
              post.title!,
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 300.0,
            actionsIconTheme: const IconThemeData(opacity: 0.40),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Positioned.fill(
                    child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                ))),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                  height: 1000.0,
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    child: Text(
                      post.description!,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
