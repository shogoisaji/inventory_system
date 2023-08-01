

class User{
  final String userName;
  final String mail;
  final String department;
  final DateTime registrationDate;

  const User({
    required this.userName,
    required this.mail,
    this.department='',
    required this.registrationDate,
  });


}