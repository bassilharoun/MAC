class LicenseData {
  LicenseData({
    this.imagePath = '',
    this.startColor = '',
    this.endColor = '',
    this.title = '',
    this.oldPrice = 0,
    this.price = "0",
    this.features ,
  });

  String imagePath;
  String startColor;
  String endColor;
  String title;
  int oldPrice;
  String price;
  List<String>? features;

}
