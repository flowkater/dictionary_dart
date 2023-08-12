/* Challenge goals:

Using everything we learned, make a Dictionary class with the following methods:
add: 단어를 추가함.
get: 단어의 정의를 리턴함.
delete: 단어를 삭제함.
update: 단어를 업데이트 함.
showAll: 사전 단어를 모두 보여줌.
count: 사전 단어들의 총 갯수를 리턴함.
upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.
bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]

Requirements:

Use class
Use typedefs
Use List
Use Map
*/

typedef Dict = Map<String, String>;
typedef ListOfDict = List<Dict>;
typedef ListOfWordDefinitions = List<Map<String, String>>;

class Dictionary {
  final Dict _words = {};

  void _add(String term, String definition) {
    _words[term] ??= definition;
  }

  String? _delete(String term) => _words.remove(term);

  void add(String term, String definition) => _add(term, definition);

  String? get(String term) => _words[term];

  String? delete(String term) => _delete(term);

  void update(String term, String definition) {
    if (_words[term] != null) {
      _words[term] = definition;
    }
  }

  List<String> showAll() {
    final result = _words.entries
        .map((e) => "term: '${e.key}', definition: '${e.value}'")
        .toList();
    print(result);
    return result;
  }

  int count() => _words.length;

  void upsert(String term, String definition) {
    _words[term] = definition;
  }

  bool exists(String term) => _words.containsKey(term);

  void bulkAdd(ListOfWordDefinitions listOfWordDefinitions) {
    for (var wordDefinition in listOfWordDefinitions) {
      if (wordDefinition["term"] != null &&
          wordDefinition["definition"] != null) {
        _add(wordDefinition["term"]!, wordDefinition["definition"]!);
      }
    }
  }

  void bulkDelete(List<String> listOfTerms) {
    for (var term in listOfTerms) {
      _delete(term);
    }
  }
}
