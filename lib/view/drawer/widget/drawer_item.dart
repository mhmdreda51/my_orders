import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
        ),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
