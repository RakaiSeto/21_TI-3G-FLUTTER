# Kamera Filter App

A Flutter application that combines camera functionality with Instagram-style photo filters.

## Features

-   📸 **Camera Integration**: Take photos using device camera
-   🎨 **Filter Carousel**: Apply Instagram-style color filters to captured photos
-   🎯 **Center-Based Selection**: Filter carousel with center-based selection and auto-snap
-   📱 **Responsive UI**: Works on both Android and iOS devices

## App Flow

1. **Camera Screen**: Take photos using the device camera
2. **Photo Display**: View the captured photo
3. **Filter Application**: Tap the filter button to show the filter carousel
4. **Filter Selection**: Scroll through filters or tap to select
5. **Real-time Preview**: See filter effects applied to your photo instantly

## Technical Implementation

### Camera Features

-   Uses `camera` plugin for device camera access
-   `CameraController` for camera management
-   `CameraPreview` for live camera feed
-   Photo capture with `takePicture()` method

### Filter Features

-   Instagram-style horizontal carousel
-   Center-based filter selection
-   Auto-snap to center functionality
-   Real-time filter preview using `ColorBlendMode`
-   Multiple color filters (white, red, blue, green, etc.)

### Key Widgets

-   `TakePictureScreen`: Camera interface
-   `DisplayPictureScreen`: Photo display with filter toggle
-   `FilterCarousel`: Main filter overlay
-   `FilterSelector`: Horizontal scrollable filter carousel
-   `FilterItem`: Individual filter items

## Dependencies

-   `camera`: ^0.11.2+1 - Camera functionality
-   `path_provider`: ^2.1.5 - File system access
-   `path`: ^1.9.1 - Path manipulation

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app
4. Grant camera permissions when prompted

## Platform Requirements

-   **Android**: minSdkVersion 21 or higher
-   **iOS**: Camera usage description in Info.plist

## Usage

1. Open the app to see the camera preview
2. Tap the camera button to take a photo
3. View your captured photo
4. Tap the filter button (filter_list icon) to show filters
5. Scroll through filters or tap to select
6. Tap close button to hide filters

## Architecture

The app follows a clean widget-based architecture:

```
main.dart
├── MyApp (Root widget with camera initialization)
└── TakePictureScreen (Camera interface)
    └── DisplayPictureScreen (Photo display)
        └── FilterCarousel (Filter overlay)
            └── FilterSelector (Filter carousel)
                └── FilterItem (Individual filters)
```

## Future Enhancements

-   Save filtered photos to gallery
-   More filter types (vintage, black & white, etc.)
-   Photo editing tools (brightness, contrast, saturation)
-   Share functionality
-   Photo gallery integration
