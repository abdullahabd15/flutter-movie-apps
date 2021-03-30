import 'package:flutter/material.dart';
import 'package:movie_app/components/screens/login_screen.dart';
import 'package:movie_app/components/screens/movies_screen.dart';
import 'package:movie_app/logic/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn;

  HomeScreen({this.isLoggedIn});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> _pagesLoggedIn() => [
    MoviesScreen(),
    Center(
      child: Text("Favorite"),
    ),
    Center(
      child: InkWell(
        child: Text("Logout"),
        onTap: () {
          doSignOut();
        },
      ),
    ),
  ];
  List<Widget> _pagedNotLoggedIn() => [MoviesScreen(), LoginScreen()];
  List<BottomNavigationBarItem> _navBarLoggedIn() => [
    BottomNavigationBarItem(
      icon: Icon(Icons.play_arrow_sharp),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Account',
    ),
  ];
  List<BottomNavigationBarItem> _navBarNotLoggedIn() => [
    BottomNavigationBarItem(
      icon: Icon(Icons.play_arrow_sharp),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Login',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var isLoggedIn = widget.isLoggedIn;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: isLoggedIn ? _pagesLoggedIn() : _pagedNotLoggedIn(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: isLoggedIn ? _navBarLoggedIn() : _navBarNotLoggedIn(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amberAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void doSignOut() {
    AuthRepository().signOut(() => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(
                isLoggedIn: false,
              ),
            ),
          )
        });
  }
}
