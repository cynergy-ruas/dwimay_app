import 'package:dwimay/pages/about/about_page.dart';
import 'package:dwimay/pages/announcements/announcements_page.dart';
import 'package:dwimay/pages/events/events_page.dart';
import 'package:dwimay/pages/faq/faq_page.dart';
import 'package:dwimay/pages/login/login_page.dart';
import 'package:dwimay/pages/main/collapsed_contents.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// The main page. It isn't technically a page, but it consists
/// of the bottom navigation bar that is used to navigate to
/// other pages.
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  /// The list of pages
  List<Widget> _pages;

  /// the index of the current page
  int _currentPage;

  @override
  void initState() {
    super.initState();

    // the pages that can be navigated to from the
    // bottom navigation bar. The order of the pages is
    // important.
    _pages = [
      AboutPage(),
      EventsPage(),
      AnnouncementsPage(),
      FAQPage()
    ];

    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    
    // the scaffold
    return Scaffold(

      // the bottom nav bar
      bottomNavigationBar: Container( // adding a shadow around the nav bar

        // the actual nav bar
        child: BottomNavigationBar(
          // the background color
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          // the type of the bar
          type: BottomNavigationBarType.fixed,

          // the index of the highlighted item
          currentIndex: _currentPage,

          // theme of unselected icon
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),

          // the icons in the nav bar
          items: <BottomNavigationBarItem> [

            // icon for the about page
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Container(),
            ),

            // the icon for the events page
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Container(),
            ),

            // the icon for the announcements page
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Container(),
            ),

            // the icon for the faq page
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              title: Container()
            )
          ],

          // defining what to do when a tab in the nav bar is tapped
          onTap: (int index) {
            setState(() {
              // setting the [_currentPage] to the index of the tapped tab
              _currentPage = index;
            });
          },
        ),
      ),

      // the body of the app is wrapped in a Bottom sheet widget 
      // called [SlidingUpPanel]. This widget displays the list
      // of registered events if the user has logged in.
      body: SafeArea(
        child: SlidingUpPanel(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0)
          ),

          // contents of the panel when collapsed, clipped at the 
          // top corners
          collapsed: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0)
            ),
            child: CollapsedContents()
          ),

          // the contents of the panel when opened, clipped at the
          // top corners
          panel: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0)
            ),
            child: LoginPage()
          ),

          minHeight: 70,

          // the body of the application
          body: Stack(
            children: <Widget>[
              // background image
              Image.asset(
                "assets/images/pattern.png",
              ),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: _pages[_currentPage],
              ),
            ],
          ),

          onPanelClosed: () {
            // sometimes, the text fields in the panel may be focused randomly.
            // If this is the case, unfocusing all the text fields when the panel closes.
            
            // getting the current focus scope node
            FocusScopeNode node = FocusScope.of(context);

            // unfocusing if it does not have primary focus
            if (! node.hasPrimaryFocus) 
              node.unfocus();
          },
          

          // not rendering the sheet
          renderPanelSheet: false,

          // setting the parallax effect
          parallaxEnabled: true,
        ),
      )
    );
  }
}
