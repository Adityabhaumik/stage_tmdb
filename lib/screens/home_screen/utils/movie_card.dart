import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/tmdb.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movieTitle,
    required this.movieGenere,
    required this.favHandler,
    required this.bannerImgUrl,
    required this.isFav,
    this.showSavedData = false,
  }) : super(key: key);
  final String movieTitle;
  final String movieGenere;
  final Function favHandler;
  final String bannerImgUrl;
  final bool isFav;
  final bool showSavedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 352,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 275,
            width: 190,
            color: Colors.white,
            child: Builder(builder: (context) {
              return CachedNetworkImage(
                  imageUrl: "$kTmdbImageBaseUrl$bannerImgUrl",
                  imageBuilder: (context, imageProvioder) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvioder, fit: BoxFit.contain),
                      ),
                    );
                  },
                  placeholder: (context, url) => Container(
                        height: 250,
                        width: 164,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) {
                    if (showSavedData == true && bannerImgUrl != null) {
                      return LocalImageWidget(filePath: bannerImgUrl!);
                    }
                    return const Icon(Icons.error);
                  });
            }),
          ),
          Container(
            height: 75,
            width: 190,
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        movieTitle,
                        style: TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        movieGenere,
                        style: TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    favHandler();
                  },
                  child: Container(
                    child: Icon(
                      Icons.favorite,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LocalImageWidget extends StatelessWidget {
  final String filePath;

  const LocalImageWidget({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);

    return FutureBuilder<bool>(
      future: file.exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        }

        if (snapshot.data == true) {
          return Image.file(file); // Show local image
        } else {
          return const Icon(Icons.image_not_supported); // Placeholder
        }
      },
    );
  }
}
