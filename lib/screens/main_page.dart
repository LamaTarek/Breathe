import 'package:breathe/screens/navigation_screens/home_screen.dart';
import 'package:breathe/screens/navigation_screens/leader_board_screen.dart';
import 'package:breathe/screens/navigation_screens/my_trees_screen.dart';
import 'package:breathe/screens/navigation_screens/plant_a_tree_screen.dart';
import 'package:flutter/material.dart';




class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> page = [
    const HomeScreen(),
    const PlantATreeScreen(),
    const MyTreesScreen(),
    const LeaderShipScreen(),
  ];
  onIndexChanged(int index){
    currentIndex = index;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: page[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          onTap: onIndexChanged,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined,), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.language_outlined), label: "Plant a tree"),
            BottomNavigationBarItem(icon: Icon(Icons.forest_outlined), label: "My trees"),
            BottomNavigationBarItem(icon: Icon(Icons.workspace_premium_outlined), label: "Leader bord"),

          ],
        )

    );
  }
}
