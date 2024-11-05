import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  const DrawerTile({super.key});

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
              child: Icon(
                Icons.note,
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/home");
              },
              title: Text(
                "Notes",
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              leading: Icon(
                Icons.note,
                color: Theme.of(context).colorScheme.secondary,
              )),
          ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/settings");
              },
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
              )),
        ],
      ),
    );
  }
}
