import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_bar_text.g.dart';

@Riverpod(keepAlive: true)
class SerchBarPro extends _$SerchBarPro {
  @override
  String build() {
    return '';
  }

  void addSearchString(String search) {
    state = search;
  }
}
