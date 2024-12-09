import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_search/model.dart';
import 'package:logger/logger.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelProvider = ref.watch(model);
    TextEditingController searchController = TextEditingController();
    Logger logger = Logger();
    double deviceWidth = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
        ),
        centerTitle: true,
        title: const Text("Image Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 2.0, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 2.0, color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2.0,
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 2.0,
                        color: Colors.red,
                      ),
                    ),
                    hintText: "Search...",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                          onPressed: () async {
                            modelProvider.photoUrls = [];
                            await modelProvider
                                .fetchImages(searchController.text);
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    )),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: deviceWidth / 1.35,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: modelProvider.photoUrls.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: modelProvider.photoUrls[index].isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                               progressIndicatorBuilder: (context,url,progress) => Center(child: CircularProgressIndicator(value: progress.progress,)),
                                imageUrl: modelProvider.photoUrls[index],
                                fit: BoxFit.fill,
                              )
                            ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}

// TODO: add images to the screen as the user scrolls,
// TODO: add the shining animation when the image is loading,
// TODO: try to optimize performance speed of the app,
// TODO: implement the error logic
// TODO: enable image download