import 'package:flutter/material.dart';
import 'package:instagram/shared/colors.dart';
import 'package:intl/intl.dart';
class Post_Design extends StatefulWidget {

  final Map data;

  const  Post_Design(
  {super.key,
    required this.data
}
      );

  @override
  State<Post_Design> createState() => _Post_DesignState();
}

class _Post_DesignState extends State<Post_Design> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: mobileBackgroundColor,
          borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.symmetric(vertical: 11,horizontal:widthScreen>600? widthScreen/6:0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)
                      ),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                          // 'https://i.pinimg.com/564x/94/df/a7/94dfa775f1bad7d81aa9898323f6f359.jpg'
                            widget.data['profileImg']

                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(widget.data['username'], style: TextStyle(fontSize: 15)),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
          ),
          Image.network(

           widget.data['imgPost']   ,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border)),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.comment_outlined)),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                        )),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_outline),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
            width: double.infinity,
            child: Text(
              widget.data['likes'].length>1? "${widget.data['likes'].length} likes":"${widget.data['likes'].length} like",
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(214, 157, 157, 165)),
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 9,
              ),
              Text(
                // "${widget.snap["username"]}",
                widget.data['username'],
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
              ),
              SizedBox(
                width: 9,
              ),
              Text(
                // " ${widget.snap["description"]}",
                widget.data['description'],
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 189, 196, 199)),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.fromLTRB(10, 13, 9, 10),
                width: double.infinity,
                child: Text(
                  'view all 100 comments',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(214, 157, 157, 165)),
                  textAlign: TextAlign.start,
                )
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 9, 10),
              width: double.infinity,
              child: Text(

                " ${ DateFormat('MMMM d,y').format(widget.data['datePublished'].toDate() as DateTime) } ",
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(214, 157, 157, 165)),
                textAlign: TextAlign.start,
              )
          ),
        ],
      ),
    );
  }
}
