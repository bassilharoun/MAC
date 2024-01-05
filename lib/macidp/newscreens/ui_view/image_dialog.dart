import 'package:flutter/material.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 16,
          child: Dialog(
            backgroundColor:
                Colors.transparent, // Set dialog background to transparent
            child: Container(
              color: Colors.transparent, // Set container color to transparent
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
                backgroundDecoration: BoxDecoration(
                    color: Colors
                        .transparent), // Set PhotoView background to transparent
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                enableRotation: true,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
            child: TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Close",style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold,fontSize: 16),))),
        Expanded(
          flex: 1,
            child: SizedBox())
      ],
    );
  }
}
