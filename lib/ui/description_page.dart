import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DescriptionPage extends HookConsumerWidget {
  final String description;
  final int likes;
  const DescriptionPage(this.description, this.likes, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    bool isDark  = Theme.of(context).brightness == Brightness.dark;
    Color blackAndWhite = isDark?Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: deviceHeight * 0.75,
            width: deviceWidth,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(value: progress.progress),
                );
              },
              errorWidget: (context, url, error) {
                return const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 30.0,
                  ),
                );
              },
              imageUrl:
                  "https://images.unsplash.com/photo-1587893904933-5b23fefaea6d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NzE5NTZ8MHwxfHNlYXJjaHwzfHxwbGFuZXxlbnwwfHx8fDE3MzM4NTI5ODB8MA&ixlib=rb-4.0.3&q=80&w=1080",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 60.0,
                width: 100.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Text(likes.toString()),
                  ],
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                label: const Text("Save"),
                icon: Icon(Icons.save_alt_rounded,color: blackAndWhite,),
              )
            ],
          )
        ],
      ),
    );
  }
}
