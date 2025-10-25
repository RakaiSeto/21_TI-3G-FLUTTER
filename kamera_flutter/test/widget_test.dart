import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';

import 'package:kamera_flutter/main.dart';

void main() {
  testWidgets('Camera app smoke test', (WidgetTester tester) async {
    // Create a mock camera description for testing
    const mockCamera = CameraDescription(
      name: 'mock_camera',
      lensDirection: CameraLensDirection.back,
      sensorOrientation: 90,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(camera: mockCamera));

    // Verify that the camera screen is displayed
    expect(find.text('Take a picture - NIM Anda'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });
}
