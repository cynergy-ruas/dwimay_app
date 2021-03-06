import 'package:dwimay/widgets/relative_delegate.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {

  /// Title widget
  final Widget title;

  /// The subtitle
  final Widget subtitle;

  /// The thumbnail
  final Widget thumbnail;

  /// The hero tag, for the thumbnail
  final Object heroTag;

  /// The height of the thumbnail
  final double thumbnailHeight;

  /// the width of the thumbnail
  final double thumbnailWidth;

  /// The height of the card
  final double height;
  
  PageHeader({
    @required this.title,
    @required this.thumbnail,
    this.subtitle,
    this.heroTag,
    this.thumbnailHeight = 80,
    this.thumbnailWidth = 80,
    this.height = 170
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: CustomMultiChildLayout(
        delegate: RelativeDelegate(objectCenter: FractionalOffset(0.5, 0)),
        children: <Widget>[
          LayoutId(
            id: Slot.bottom,
            child: _bottomContent(context),
          ),
          LayoutId(
            id: Slot.top,
            child: _topContent(),
          ), 
        ],
      ),
    );
  }

  /// The content on the top. Consists of the thumbnail
  Widget _topContent() {
    if (heroTag != null)
     return Hero(
        tag: heroTag,
        child: thumbnail
      );
    return thumbnail;
  }

  /// The content on the bottom. Consists of the title, venue
  /// and data
  Widget _bottomContent(BuildContext context) => 
    Card(
      elevation: 10,
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(height: thumbnailHeight / 2 + 10,),

          // title
          Expanded(
            child: title
          ),

          // gap
          SizedBox(height: 10,),
        ]
        // adding separator if subtitle is present
        ..addAll(
          (subtitle != null)
          ? [
            // separator
            _separator(),

            // subtitle
            subtitle
          ]
          : [
            Container()
          ]
        ),
      ),
    );

  /// seperator that seperates the title from subtitle
  Widget _separator() {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 8.0),
      height: 2.0,
      width: 18.0,
      color: new Color(0xff00c6ff),
    );
  }
}
