import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/image_path.dart';
import 'package:pawndr/Utils/responsive.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  var asset,network,thumbnail,fileImage;
  ImagePreview({this.asset,this.network,this.thumbnail,this.fileImage});
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      decoration: BoxDecoration(

      ),
        child:
        asset !=null? PhotoView(
          imageProvider: AssetImage(asset)
        )
        : network !=null? PhotoView(
            imageProvider: NetworkImage(network)
        ):thumbnail !=null? PhotoView(
            imageProvider: FileImage(thumbnail)
        ):fileImage !=null?
        PhotoView(
            imageProvider: Image.file(fileImage).image)
            : PhotoView(
            imageProvider: AssetImage(ImagePath.noImageFound)
        )
    );
  }
}
