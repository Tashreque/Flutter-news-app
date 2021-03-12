import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryBasedItem extends StatelessWidget {
  final String headline;
  final String subHeadline;
  final String source;
  final String author;
  final String date;
  final String time;
  final String headlineImageUrl;

  const CategoryBasedItem(
      {Key key,
      this.headline,
      this.subHeadline,
      this.source,
      this.author,
      this.headlineImageUrl,
      this.date,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (headlineImageUrl != null)
                ? CachedNetworkImage(
                    imageUrl: headlineImageUrl,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                    ),
                  ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        this.headline ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                this.author != null
                                    ? "Author - " + this.author
                                    : "",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                this.date + "\n" + this.time,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
