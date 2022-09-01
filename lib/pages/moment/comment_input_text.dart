import 'package:flutter/material.dart';


class CommentInputText extends StatefulWidget {
  const CommentInputText({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommentInputTextState();
  }
}

class CommentInputTextState extends State<CommentInputText> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("showModalBottomSheet"),
      ),
      body: Center(

      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: bottomNewCommentButton(),
      // ),
    );
  }

  // Container bottomNewCommentButton(){
  //   return Container(
  //     child: RaisedButton(
  //       child: Text("Publish", style: TextStyle(fontSize: 20.0, color: Colors.white)),
  //       color: Colors.blue[300],
  //       onPressed: () {
  //         showModalBottomSheet(
  //           context: context,
  //           builder: (BuildContext context){
  //             return AnimatedPadding(
  //               padding: MediaQuery.of(context).viewInsets,
  //               duration: const Duration(milliseconds: 100),
  //               child: Container(
  //                 child: textField(),
  //                 padding: EdgeInsets.all(7),
  //               ),
  //             );
  //           }
  //         );
  //       },
  //     ),
  //     height: 50,
  //   );
  // }



}