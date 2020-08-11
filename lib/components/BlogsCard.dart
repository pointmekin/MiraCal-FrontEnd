import 'package:flutter/material.dart';

class BlogsCard extends StatefulWidget {
  @override
  _BlogsCardState createState() => _BlogsCardState();
}

class _BlogsCardState extends State<BlogsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Blog card Clicked');
      },
      splashColor: Colors.white12,
      focusColor: Colors.white30,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                -5.0, // Move to right 10  horizontally
                -5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 15, 25, 10),
        height: 200,
        width: 380,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,

                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Blog 1",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 26),
                        ),
                      ],
                    ),
                  ),

                ]
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
            ),
          ],
        ),
      ),
    );
  }
}
