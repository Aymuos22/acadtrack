import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Semester {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double gpa;

  @HiveField(2)
  late double credits;

  Semester(this.name, this.gpa, this.credits);
}

class SemesterAdapter extends TypeAdapter<Semester> {
  @override
  int get typeId => 0;

  @override
  Semester read(BinaryReader reader) {
    return Semester(
        reader.readString(), reader.readDouble(), reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, Semester obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.gpa);
    writer.writeDouble(obj.credits);
  }
}
