import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/channel_drawer.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/date_picker_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/program_list_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/error_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

void main() {
  group('Widgets', () {
    test('ChannelDrawer should exist', () {
      expect(ChannelDrawer, isA<Type>());
    });

    test('DatePickerWidget should exist', () {
      expect(DatePickerWidget, isA<Type>());
    });

    test('ProgramListWidget should exist', () {
      expect(ProgramListWidget, isA<Type>());
    });

    test('ProgramTileWidget should exist', () {
      expect(ProgramTileWidget, isA<Type>());
    });

    test('AppErrorWidget should exist', () {
      expect(AppErrorWidget, isA<Type>());
    });

    test('LoadingWidget should exist', () {
      expect(LoadingWidget, isA<Type>());
    });
  });
}
