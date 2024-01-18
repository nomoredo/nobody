abstract class AbstractUrl {
  String get url;
}


class Url implements AbstractUrl {
  final String url;
  const Url(this.url);
}

