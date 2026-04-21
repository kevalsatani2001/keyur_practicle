import 'package:hive/hive.dart';

part 'contact_model.g.dart'; // Aa file generate thase

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  ContactModel({required this.name, required this.phone, required this.email});
}