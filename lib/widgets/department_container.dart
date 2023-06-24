import 'package:flutter/material.dart';

class DepartmentContainer extends StatelessWidget {
  final String text;
  final screen;
  final String icon;
  const DepartmentContainer(
      {super.key, required this.text, required this.screen, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        height: 50,
       width: 170,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.4),
        ),
        child: Align(
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ SizedBox(height: 20, child: Image.asset(icon)),
                Text(
                  text,
                ),
              ],
            )),
      ),
    );
  }
}
