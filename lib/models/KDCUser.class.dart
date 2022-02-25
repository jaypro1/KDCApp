class KDCUser {
  late String name;
  late String group;
  late String role;

  KDCUser(this.name, this.group, this.role);

  Map<String, dynamic> getDataMap() => {
        'name': name,
        'group': group,
        'role': role,
      };
}
