class UserModel{
  dynamic name ;
  String? email ;
  dynamic phone ;
  dynamic  uId;
  dynamic  image;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
});

  UserModel.fromJson(Map<String , dynamic>? json){
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'email' : email ,
      'phone' : phone ,
      'uId' : uId ,
      'image' : image ,
    };
  }
}