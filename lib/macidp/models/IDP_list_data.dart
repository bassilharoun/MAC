import 'package:macidp/macidp/models/products_model.dart';

class IdpListData {
  IdpListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.Idp,
    this.kacl = "0",
    this.product,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? Idp;
  String kacl;
  Products? product;
}
