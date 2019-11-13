import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'peoples.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class peoples {
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;

  peoples(
      {this.id,
        this.employeeName,
        this.employeeSalary,
        this.employeeAge,
        this.profileImage});

  peoples.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    employeeSalary = json['employee_salary'];
    employeeAge = json['employee_age'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_name'] = this.employeeName;
    data['employee_salary'] = this.employeeSalary;
    data['employee_age'] = this.employeeAge;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

