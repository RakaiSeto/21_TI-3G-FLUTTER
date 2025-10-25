import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_filter_carousel/widget/filter_carousel.dart';
import 'package:photo_filter_carousel/widget/filter_selector.dart';

void main() {
  testWidgets('Photo filter carousel smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: PhotoFilterCarousel()));

    // Verify that the filter carousel is displayed
    expect(find.byType(PhotoFilterCarousel), findsOneWidget);
    expect(find.byType(FilterSelector), findsOneWidget);
  });
}
