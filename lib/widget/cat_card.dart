import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tca/model/bread.dart';

class ShimmerImage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final double width;
  final double height;

  const ShimmerImage({
    super.key,
    required this.imageUrl,
    this.tag = "",
    this.width = double.infinity,
    this.height = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }
}

// "https://cdn2.thecatapi.com/images/vJ3lEYgXr.jpg",
class CatCard extends StatelessWidget {
  final CatBreed catBreed;
  const CatCard({super.key, required this.catBreed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    catBreed.name ?? "",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const Expanded(
                    child: Text(
                      "More...",
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: catBreed.referenceImageId != null
                    ? ShimmerImage(
                        imageUrl:
                            "https://cdn2.thecatapi.com/images/${catBreed.referenceImageId}.jpg",
                        height: 300,
                        tag: catBreed.id ?? "",
                      )
                    : const SizedBox(
                        height: 300,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    catBreed.origin ?? "-",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: Text(
                      catBreed.temperament ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
