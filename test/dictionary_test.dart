import 'package:dictionary/dictionary.dart';
import 'package:test/test.dart';

Dictionary getBaseDictionary() {
  final dictionary = Dictionary();

  dictionary.add('apple', '사과');
  dictionary.add('orange', '오렌지');
  dictionary.add('tony', '토니');

  return dictionary;
}

void main() {
  test('Dictionary object test', () {
    final dictionary = Dictionary();

    expect(dictionary, isNotNull);
  });

  test('Map<String,String> is Dict', () {
    Dict words = {};

    expect(words is Map<String, String>, true);
  });

  test('List<Map<String,String>> is ListOfDict', () {
    ListOfDict listOfWords = [];

    expect(listOfWords is List<Map<String, String>>, true);
  });

  test('List<Map<String, String>> is ListOfWordDefinitions', () {
    ListOfWordDefinitions listOfWordDefinitions = [];

    expect(listOfWordDefinitions is List<Map<String, String>>, true);
  });

  // add: 단어를 추가함.
  test('add Dictionary', () {
    final dictionary = Dictionary();

    dictionary.add('apple', '사과');

    expect(dictionary.get('apple'), '사과');

    dictionary.add('orange', '오렌지');
    dictionary.add('tony', '토니');

    // expect(dictionary.words, {
    //   'apple': '사과',
    //   'orange': '오렌지',
    //   'tony': '토니',
    // });

    expect(dictionary.get('orange'), '오렌지');
    expect(dictionary.get('tony'), '토니');
    expect(dictionary.count(), 3);
  });

  // get: 단어의 정의를 리턴함.
  test('get Dictionary', () {
    final dictionary = Dictionary();

    dictionary.add('apple', '사과');

    expect(dictionary.get('apple'), '사과');
    expect(dictionary.get('orange'), null);

    dictionary.add('orange', '오렌지');
    dictionary.add('tony', '토니');

    expect(dictionary.get('orange'), '오렌지');
    expect(dictionary.get('tony'), '토니');
    expect(dictionary.get('flowkater'), null);
  });

  // delete: 단어를 삭제함.
  test('delete Dictionary', () {
    final dictionary = getBaseDictionary();

    expect(dictionary.get('orange'), '오렌지');
    expect(dictionary.delete('orange'), '오렌지');
    expect(dictionary.get('orange'), null);

    expect(dictionary.get('apple'), '사과');
    expect(dictionary.delete('apple'), '사과');

    expect(dictionary.get('apple'), null);

    expect(dictionary.delete('flowkater'), null);
  });

  // update: 단어를 업데이트 함.
  test('update Dictionary', () {
    final dictionary = getBaseDictionary();

    expect(dictionary.get('orange'), '오렌지');
    dictionary.update('orange', '오랜오렌지');
    expect(dictionary.get('orange'), '오랜오렌지');

    dictionary.update('flowkater', '닉네임');
    expect(dictionary.get('flowkater'), null);
  });

  // showAll: 사전 단어를 모두 보여줌.
  test('showAll Dictionary', () {
    final dictionary = getBaseDictionary();

    expect(dictionary.showAll(), [
      "term: 'apple', definition: '사과'",
      "term: 'orange', definition: '오렌지'",
      "term: 'tony', definition: '토니'",
    ]);
  });

  // count: 사전 단어들의 총 갯수를 리턴함.
  test('count Dictionary', () {
    final dictionary = getBaseDictionary();

    expect(dictionary.count(), 3);

    dictionary.add('flowkater', '닉네임');
    dictionary.add('update', '업데이트');

    expect(dictionary.count(), 5);

    final dictionary2 = Dictionary();
    expect(dictionary2.count(), 0);
  });

  test('add improve Dictionary', () {
    final dictionary = getBaseDictionary();

    dictionary.add('orange', '오랜오렌지');
    expect(dictionary.get('orange'), '오렌지');

    dictionary.add('grape', '포도');
    expect(dictionary.get('grape'), '포도');
  });

  // upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함.
  // (update + insert = upsert)
  test('upsert Dictionary', () {
    final dictionary = getBaseDictionary();

    dictionary.upsert('orange', '오랜오렌지');
    expect(dictionary.get('orange'), '오랜오렌지');

    dictionary.upsert('grape', '포도');
    expect(dictionary.get('grape'), '포도');
  });

  // exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.
  test('exists Dictionary', () {
    final dictionary = getBaseDictionary();

    expect(dictionary.exists('apple'), true);
    expect(dictionary.exists('grape'), false);
  });

  // bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌.
  // [ {"term":"김치", "definition":"대박이네~"},
  // {"term":"아파트", "definition":"비싸네~"} ]
  test("bulkAdd Dictionary", () {
    final dictionary = Dictionary();

    dictionary.bulkAdd([
      {"term": "김치", "definition": "대박이네~"},
      {"term": "아파트", "definition": "비싸네~"}
    ]);

    expect(dictionary.get('김치'), '대박이네~');
    expect(dictionary.get('아파트'), '비싸네~');
    expect(dictionary.get('apple'), null);
  });

  test("bulkAdd exist Dictionary", () {
    final dictionary = getBaseDictionary();

    dictionary.bulkAdd([
      {"term": "김치", "definition": "대박이네~"},
      {"term": "아파트", "definition": "비싸네~"},
      {"term": 'apple', "definition": "구아바"},
    ]);

    expect(dictionary.get('김치'), '대박이네~');
    expect(dictionary.get('아파트'), '비싸네~');
    expect(dictionary.get('apple'), '사과');
  });

  // bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌.
  // ["김치", "아파트"]
  test("bulkDelete exist Dictionary", () {
    final dictionary = getBaseDictionary();

    expect(dictionary.count(), 3);

    dictionary.bulkDelete(["apple", "tony"]);
    expect(dictionary.count(), 1);
    expect(dictionary.get('apple'), null);
    expect(dictionary.get('tony'), null);
    expect(dictionary.get('orange'), '오렌지');
  });
}
