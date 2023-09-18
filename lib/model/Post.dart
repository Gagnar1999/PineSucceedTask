/// userId : 4
/// id : 40
/// title : "enim quo cumque"
/// body : "ut voluptatum aliquid illo tenetur nemo sequi quo facilis\nipsum rem optio mollitia quas\nvoluptatem eum voluptas qui\nunde omnis voluptatem iure quasi maxime voluptas nam"

class Post {
  Post({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
  }

  Post.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }

  int? _userId;
  int? _id;
  String? _title;
  String? _body;

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      Post(
        userId: userId ?? _userId,
        id: id ?? _id,
        title: title ?? _title,
        body: body ?? _body,
      );

  int? get userId => _userId;

  int? get id => _id;

  String? get title => _title;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }
}
