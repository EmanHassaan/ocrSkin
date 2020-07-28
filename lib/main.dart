import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





String block1 ="";
File pickedImage;
bool isimageloaded = false;
 Future PickImage()async{
var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

setState(() {
  pickedImage =tempStore;
  isimageloaded= true;

});
 }




 Future readtext ()async{
 FirebaseVisionImage ourimage = FirebaseVisionImage.fromFile(pickedImage);
 TextRecognizer recogniztext = FirebaseVision.instance.textRecognizer();
 VisionText readtext = await recogniztext.processImage(ourimage);

setState(() {
  block1=readtext.text;
});


 
 }

 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body: Column(
     children:<Widget>[
      isimageloaded? Center(
         child:Container(
           height:200.0,
           width:200.0,
           decoration:BoxDecoration(
             image:DecorationImage(image: FileImage(pickedImage),fit:BoxFit.cover)
           )
         )
       ):Container(),
       SizedBox(
         height: 10.0,
       ),
    RaisedButton(
      child: Text('pick an image'),
      onPressed: PickImage,
      ),
      SizedBox(
        height:10.0
      ),
      RaisedButton(
        child: Text('read text'),
        onPressed: readtext
        ), 
        SizedBox(
          height: 30.0,
        ),
       Text(block1)
    
     ]
   ),
    );
  }
}
