class Test {
  final int id;
  final String name;

  Test({this.id, this.name});
}

class TestE extends Test {
  final job;

  TestE({
    this.job,
    id,
    name,
  }) : super(id: id, name: name);
}

main() {
  TestE test = new TestE(job: "actor", id: 0, name: "Antoine");
  print(test.id);
  print(test.job);
  print(test.name);
}
