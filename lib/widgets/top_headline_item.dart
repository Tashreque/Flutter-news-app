import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_news/global_variables/global_variables.dart';

class TopHeadlineItem extends StatelessWidget {
  final String headline;
  final String subHeadline;
  final String source;
  final String author;
  final String elapsedTime;
  final String headlineImageUrl;
  final Function onPressed;
  const TopHeadlineItem(
      {Key key,
      this.headline,
      this.subHeadline,
      this.source,
      this.author,
      this.headlineImageUrl,
      this.elapsedTime,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double headlineWidth =
        currentPlatform == CurrentPlatform.web ? 600 : 300;
    return Container(
      width: headlineWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          (headlineImageUrl != null)
              ? CachedNetworkImage(
                  imageUrl: headlineImageUrl,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Center(
                      child:
                          CircularProgressIndicator(value: progress.progress),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: headlineWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  width: headlineWidth,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
          Opacity(
            opacity: 0.75,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              height: 300,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        (this.headline != null) ? this.headline : "",
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(
                        (this.subHeadline != null) ? this.subHeadline : "",
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        (this.source != null) ? this.source : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        (this.author != null)
                            ? ("Author - " + this.author)
                            : "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        (this.elapsedTime != null || this.elapsedTime.isEmpty)
                            ? this.elapsedTime + " ago"
                            : "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
