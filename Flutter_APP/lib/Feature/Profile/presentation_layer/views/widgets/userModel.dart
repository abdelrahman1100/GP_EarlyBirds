

class userModel{
  String id;
  String userName;
  String Mail;
  String password;
  String? img;
  String token;
  userModel({required this.userName,required this.Mail, this.img, required this.password, required this.id, required this.token});
}