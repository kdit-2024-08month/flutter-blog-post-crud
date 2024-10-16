List<Map<String, dynamic>> list = [
  {"id": 1, "title": "제목1"},
  {"id": 2, "title": "제목2"},
  {"id": 3, "title": "제목3"},
];

// Dart 3에서 제공하는 record type을 사용
class HelloModel {
  List<({int id, String title})> posts = [];
  HelloModel(this.posts);
}

var record = (id: 1, title: "제목1");

void main() {
  // Map의 각 요소를 record 타입으로 변환하여 리스트에 추가
  List<({int id, String title})> rs = list
      .map((e) => (id: e["id"] as int, title: e["title"] as String))
      .toList();
  HelloModel model = HelloModel(rs);

  // 첫 번째 record에 접근하여 필드 출력
  var d = model.posts[0];
  print(d.id); // 출력: 1
  print(d.title); // 출력: 제목1
}
