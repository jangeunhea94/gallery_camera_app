// -------------------------------------전체 설명-----------------------------------------
//        Gallery 또는 Camera 에서 사진을 가져와서 -> imageFile에 저장 -> 화면에 보여주는 app

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  XFile? imageFile;                           // ? 이 표시를 넣어서 null 값도 허용하도록 함. XFile은 ios, android 모두 사용 가능
                                              //  XFile 은 class, 선택한 이미지 파일의 정보를 담는 객체
                                              // 처음에는 null 값으로 시작

  final ImagePicker picker = ImagePicker();   // 카메라나 갤러리에서 이미지를 선택할 수 있도록 하는 객체 
                                              // final은 변경하지 말라는 뜻 
                                              // picker 사진 가져오는 담당자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery & Camera'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getImageFromDevice(ImageSource.gallery);
                    }, 
                    child: Text('Gallery')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                    onPressed: () {
                      getImageFromDevice(ImageSource.camera);
                    }, 
                    child: Text('Camera'))
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: imageFile == null 
                ? Text('Image is not selected!')
                : Image.file(File(imageFile!.path))  // Image.file 스마트 폰 내에 있는 file에서 사용함. 
                                                     // imageFile!.path 해당 파일의 경로만 가져오라는 것!
                               // ㄴ> 예) C 
                ,
              ),
            )
          ],
        ),
      ),
    );
  }//build

  //-------Function-------
  void getImageFromDevice(ImageSource imageSource)async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);  // await 할때는 기다려주니까 async 필요!
    if(pickedFile == null){
      imageFile == null;
    }else{
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
  }
}//class