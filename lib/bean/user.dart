class User{

  int id;
  String name;
  String age;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["age"] = age;
    return map;
  }

  static User fromMap(Map<String, dynamic> map) {
    User user = new User();
    user.id = map["id"];
    user.name = map["name"];
    user.age = map["age"];
    return user;
  }


  static List<User> fromMapList(List<Map<String, dynamic>> mapList) {
    List<User> userList = new List(mapList.length);
    for(var map in mapList) {
      userList.add(fromMap(map));
    }
    return userList;
  }
}