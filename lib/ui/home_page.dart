import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_search/model.dart';
import 'package:image_search/ui/description_page.dart';
import 'package:logger/logger.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelProvider = ref.watch(model);
    TextEditingController searchController = TextEditingController();
    Logger logger = Logger();
    double deviceHeight = MediaQuery.of(context).size.height;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color blackAndWhite = isDarkMode ? Colors.white : Colors.black;
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
                      borderSide: BorderSide(width: 2.0, color: blackAndWhite),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.0, color: blackAndWhite),
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
              height: deviceHeight / 1.35,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: modelProvider.photoUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                              modelProvider.descriptions[index] ?? "",
                              modelProvider.likes[index] ?? 0,
                              modelProvider.photoUrls[index]),
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 30.0,
                              ),
                            ),
                            imageUrl: modelProvider.photoUrls[index],
                            fit: BoxFit.cover,
                          ),
                        ),
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
// TODO: enable image download
