import 'package:flutter/material.dart';
class Fullscreen extends StatefulWidget {
  final String imageUrl;
  const Fullscreen({Key? key,required this.imageUrl}): super (key: key);

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
        children: [
          Expanded(child: Container(
child: Image.network(widget.imageUrl,),
          )
          ),
           InkWell(
              onTap: (){
         
              },
              child: Container(
                height:60,
                width: double.infinity,
                color: Colors.black,
                child: Center(child: Text("Set Wallpaper",style: TextStyle(fontSize: 20,color: Colors.white),)),
              ),
            )
        ],
        ),
      ),
    );
  }
}