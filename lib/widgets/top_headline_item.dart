import 'package:flutter/material.dart';

class TopHeadlineItem extends StatelessWidget {
  final String headline;
  final String subHeadline;
  final String source;
  final String author;
  final String headlineImageUrl;
  const TopHeadlineItem(
      {Key key,
      this.headline,
      this.subHeadline,
      this.source,
      this.author,
      this.headlineImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      clipBehavior: Clip.hardEdge,
      decoration: (headlineImageUrl != null)
          ? BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(headlineImageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            )
          : BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(25),
            ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.black,
              height: 280,
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
