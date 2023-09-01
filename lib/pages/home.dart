import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/pages/dasboard.dart';
import 'package:simasjid/pages/profile.dart';
import 'package:simasjid/pages/v_kiblat.dart';

class HomePage extends StatefulWidget {
  // final String? userName;
  // final String? userEmail;
  // final String? imageUrl;

  // HomePage({this.userName, this.userEmail, this.imageUrl});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Properties
  int currentTab = 0;

  List<Widget> screens = [
    Dashboard(),
    Profile(),
  ]; // to store tab views

  //active page
  Widget currentSreen = Dashboard(); //initial screen in viewport

  final PageStorageBucket bucket = PageStorageBucket();
  String googleToken = '';

  @override
  void initState() {
    super.initState();
    _loadGoogleToken();
  }

  Future<void> _loadGoogleToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      googleToken = prefs.getString('googleToken') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentSreen,
      ),
      //FAB Button
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.mosque,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 150, 126, 118),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return KiblatView();
          }));
        },
      ),
      //FAB Position

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Button APP bar

      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 238, 227, 203),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentSreen = Dashboard();
                          currentTab = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0
                              ? Color.fromARGB(255, 150, 126, 118)
                              : Colors.grey,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color.fromARGB(255, 150, 126, 118)
                                : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentSreen = Profile();

                          currentTab = 1;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 1
                              ? Color.fromARGB(255, 150, 126, 118)
                              : Colors.grey,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color.fromARGB(255, 150, 126, 118)
                                : Colors.grey,
                          ),
                        )
                      ],
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
