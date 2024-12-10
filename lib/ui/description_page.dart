import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_search/components.dart';

class DescriptionPage extends HookConsumerWidget {
  final String description;
  final int likes;
  final String url;
  const DescriptionPage(this.description, this.likes, this.url, {super.key});

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
              imageUrl: url,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: OpenSans(text: description, color: blackAndWhite),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.transparent),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    OpenSans(text: " ${likes.toString()}", color: blackAndWhite),
                  ],
                ),
              ),
              FrostedGlass(
                height: 50.0,
                width: 100.0,
                borderColor: blackAndWhite,
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  label: OpenSans(text: "Save", color: blackAndWhite),
                  icon: Icon(Icons.save_alt_rounded,color: blackAndWhite,),
                ),
              )

            ],
          ),
          const SizedBox(height: 50.0,)
        ],
      ),
    );
  }
}
