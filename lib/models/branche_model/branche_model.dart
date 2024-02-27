class BranchModel
{
  String? uId;
  String? branchID;
  String? branchName;
  String? userName;
  String? description;
  String? address;
  String? dateTime;
 late List<String>? imageUrls=[];
 late List<String>? videoUrls=[];
  BranchModel({
    this.uId,
    this.branchID,
    this.branchName,
    this.userName,
    this.description,
    this.address,
    this.dateTime,
    this.imageUrls,
    this.videoUrls,
  });
  BranchModel.fromJson(Map<String,dynamic>json){
    uId=json['uId'];
    branchID=json['branchID'];
    branchName=json['branchName'];
    userName=json['userName'];
    description=json['description'];
    address=json['address'];
    dateTime=json['dateTime'];
    json['imageUrls'].forEach((element){
      imageUrls!.add(element);
    });
    json['videoUrls'].forEach((element){
      videoUrls!.add(element);
    });

  }

  Map<String,dynamic>toMap(){
    return {
      'uId':uId,
      'branchID':branchID,
      'branchName':branchName,
      'userName':userName,
      'description':description,
      'address':address,
      'dateTime':dateTime,
      'imageUrls':imageUrls,
      'videoUrls':videoUrls,
    };
  }
}