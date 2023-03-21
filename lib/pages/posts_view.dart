import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/const.dart';
import 'package:news/cubit/nav_cubit.dart';
import 'package:news/cubit/posts_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news/models/post.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Mark all read",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: myColor,
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<PostsBloc>(context).add(PullToRefreshEvent()),
              child: Container(
                color: myColor,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 30, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Featured",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  CarouselSlider.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index, realIdx) {
                      return GestureDetector(
                        onTap: () => BlocProvider.of<NavCubit>(context)
                            .showPostDetails(state.posts[index]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: myColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: max(300, 500),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    opacity: 0.40,
                                    image: NetworkImage(
                                      state.posts[index].imageUrl!,
                                    )),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    state.posts[index].title!,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      aspectRatio: 10 / 7,
                      onPageChanged: null,
                      autoPlay: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 30, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Latest news",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                        key: ValueKey(state.posts),
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => BlocProvider.of<NavCubit>(context)
                                .showPostDetails(state.posts[index]),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    height: 70,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              state.posts[index].imageUrl!)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Flexible(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.posts[index].title!,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              daysAgo(state.posts[index]
                                                  .publicationDate!),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 154, 154, 154),
                                                  fontSize: 12),
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ]),
              ),
            );
          } else if (state is FailedToLoadPostsState) {
            return Center(
              child: Text('Error occured: ${state.error}'),
            );
          } else {
            return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2));
          }
        },
      ),
    );
  }
}
