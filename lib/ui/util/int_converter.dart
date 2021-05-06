// @dart=2.9

import 'dart:convert';
import 'dart:typed_data';

class IntConverter extends Converter<List<int>, List<int>> {
  const IntConverter();

  List<int> convert(List<int> data) {
    if (data is Uint8List) {
      return data.buffer.asInt64List();
    } else {
      return new Uint64List.fromList(data).buffer.asUint8List();
    }
  }

  IntSink startChunkedConversion(sink) {
    return new IntSink(sink);
  }
}

class IntSink extends ChunkedConversionSink<List<int>> {
  final _converter;
  // fales when this type is used
  // final ChunkedConversionSink<List<int>> _outSink;
  final _outSink;

  IntSink(this._outSink) : _converter = new IntConverter();

  void add(List<int> data) {
    _outSink.add(_converter.convert(data));
  }

  void close() {
    _outSink.close();
  }
}