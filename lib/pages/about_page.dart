import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// The about page. Contains the introduction to the fest.
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Center(

        // adding the contents in a column so they appear one after
        // the other.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20,), // used to add a gap between the contents.
            
            // the title
            Text(
              Strings.festName,
              style: Theme.of(context).textTheme.title
            ),
            SizedBox(height: 20,),

            // the about content, fills the rest of the space.
            // hence, in a [Flexible]
            Flexible(
              // making the text scrollable
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                // the about content.
                child: Text(
                  Strings.aboutContent * 10,
                  style: Theme.of(context).textTheme.body1,
                ),
              )
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}