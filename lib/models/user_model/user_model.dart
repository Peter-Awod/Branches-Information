class UserModel
{
  String? name;
  String? email;
  String? uId;
  bool? isAdmin;
  UserModel({
    this.name,
    this.email,
    this.uId,
    this.isAdmin,
});
  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uId'];
    isAdmin=json['isAdmin'];
  }

 Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'uId':uId,
      'isAdmin':isAdmin,
    };
 }
}