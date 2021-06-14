// @dart=2.9

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

class IntConverter extends Converter<List<int>, List<int>> {
  const IntConverter();

  @override
  List<int> convert(List<int> data) {
    if (data is Uint8List) {
      return data.buffer.asInt64List();
    } else {
      return Uint64List.fromList(data).buffer.asUint8List();
    }
  }

  @override
  IntSink startChunkedConversion(Sink<List<int>> sink) {
    return IntSink(sink);
  }
}

class IntSink extends ChunkedConversionSink<List<int>> {
  IntSink(this._outSink) : _converter = const IntConverter();

  final _converter;
  // fales when this type is used
  // final ChunkedConversionSink<List<int>> _outSink;
  final _outSink;

  @override
  void add(List<int> chunk) {
    _outSink.add(_converter.convert(chunk));
  }

  @override
  void close() {
    _outSink.close();
  }
}
