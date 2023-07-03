import 'package:hive/hive.dart';

part 'address_entity.g.dart';

@HiveType(typeId: 7)
class AddressEntity extends HiveObject {
  AddressEntity({
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.district,
    required this.commune,
    required this.note,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String address;

  @HiveField(3)
  String city;

  @HiveField(4)
  String district;

  @HiveField(5)
  String commune;

  @HiveField(6)
  String note;

  @override
  String toString() {
    return '$name: $phone: $address : $city: $district: $commune: $note';
  }
}
