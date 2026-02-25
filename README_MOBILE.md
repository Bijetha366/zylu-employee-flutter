# Zylu Employees Flutter App

A comprehensive mobile application for viewing and managing employee information with a beautiful, intuitive interface. The app connects to the Laravel backend to display employee data with advanced features and search capabilities.

## App Features

- **Employee List View**: Beautiful card-based layout displaying employee information
- **Employee Details Screen**: Comprehensive employee profile with all details
- **Advanced Search**: Search employees by name or employee ID
- **Bottom Navigation**: Seamless navigation between Home and Search screens
- **Veteran Employee Recognition**: Special green flag for employees with 5+ years and active status
- **Real-time Data**: Live connection to Laravel backend
- **Profile Images**: Display employee profile photos with fallback
- **Gender Display**: Properly formatted gender information
- **Performance Ratings**: Visual rating display with star indicators

## Employee Information Display

### Employee Card (List View)
- **Profile Image**: Employee photo with elegant fallback
- **Name**: Full name in bold, prominent display
- **Employee ID**: Unique identifier
- **Gender**: Formatted gender display (Male/Female/Other)
- **Company Name**: Current company/department
- **Status**: Active/Inactive status indicator
- **Rating**: Performance rating (1-10) with star icon
- **Veteran Badge**: Green border and "5+ Years • Active" badge for qualified employees

### Employee Details Screen
- **Profile Image**: Large display with high-quality fallback
- **Personal Information**:
  - Full Name
  - Email Address
  - Phone Number
  - **Gender**: Properly capitalized (Male/Female/Other)
  - **Address**: Complete residential address
  - **Company Name**: Current organization
- **Professional Information**:
  - **Employee ID**: Unique identifier
  - **Joining Date**: Employment start date
  - **Years Worked**: Calculated duration of employment
  - **Rating**: Performance rating with star display
- **Status Information**:
  - **Active Status**: Current employment status
  - **Veteran Recognition**: Special indicator for 5+ years active employees

## Special Features

### Veteran Employee Recognition
Employees who meet both criteria receive special visual treatment:
- **5+ Years of Service**: Calculated from joining date
- **Currently Active**: Status must be active
- **Visual Indicators**:
  - Green border around employee card
  - "5+ Years • Active" badge
  - Enhanced visual prominence

### Search Functionality
- **Real-time Search**: Instant results as you type
- **Search Fields**:
  - Employee Name (partial matching)
  - Employee ID (partial matching)
- **Debounced Search**: 500ms delay to optimize performance
- **No Results State**: Helpful message when no matches found
- **Loading States**: Visual feedback during search

## System Requirements

- **Flutter**: >= 3.0.0
- **Dart**: >= 2.17.0
- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Backend**: Laravel admin panel running on port 8000

## Installation & Setup Guide

### 1. Prerequisites

#### Install Flutter
```bash
# Download Flutter from https://flutter.dev/docs/get-started/install
# Follow platform-specific installation instructions

# Verify installation
flutter doctor
```

#### Setup Android/iOS Development
- **Android**: Android Studio with Android SDK
- **iOS**: Xcode (macOS only)

### 2. Backend Setup (Required)

#### Start Laravel Backend
```bash
# Navigate to backend directory
cd zylu_employee

# Start Laravel development server
php artisan serve
```

The backend must be running on `http://localhost:8000`

### 3. Mobile App Setup

#### Clone Repository
```bash
# Clone the Flutter app
git clone <flutter-repository-url>
cd zylu_employees_flutter
```

#### Clean and Install Dependencies
```bash
# Clean previous build files
flutter clean

# Get required packages
flutter pub get

# Check for any issues
flutter doctor
```

### 4. Device/Emulator Setup

#### Android Setup
```bash
# List available devices
flutter devices

# Start Android emulator or connect physical device
# Ensure USB debugging is enabled for physical devices
```

#### iOS Setup (macOS only)
```bash
# Start iOS Simulator
open -a Simulator

# Or use Xcode to select simulator
```

### 5. Backend Connection Setup

#### Port Forwarding (Required for Android Emulator)
```bash
# Forward backend port to emulator
adb reverse tcp:8000 tcp:8000

# Verify connection
curl http://localhost:8000/api/mobile/users
```

#### Physical Device Setup
For physical devices, ensure your computer and device are on the same network:
- Update the base URL in `lib/constants.dart` to your computer's IP address
- Example: `static const String baseUrl = 'http://192.168.1.100:8000/';`

### 6. Run the Application

#### Development Mode
```bash
# Run in debug mode
flutter run

# Run on specific device
flutter run -d <device_id>

# Run with hot reload enabled
flutter run --hot
```

#### Release Mode (Testing)
```bash
# Build and run in release mode
flutter run --release
```

## App Navigation & Usage

### Bottom Navigation Bar

The app features a clean bottom navigation bar with two main sections:

#### Home Tab
- **Purpose**: Browse all employees
- **Features**:
  - Paginated employee list (10 per page)
  - Pull-to-refresh functionality
  - Load more on scroll
  - Tap any employee to view details

#### Search Tab
- **Purpose**: Search specific employees
- **Features**:
  - Real-time search bar
  - Search by name or employee ID
  - Instant results display
  - Tap results to view details

### Employee List (Home Screen)

#### Visual Layout
- **Card Design**: Modern card-based layout
- **Profile Section**: Circular profile image on the left
- **Information Section**: Employee details on the right
- **Status Indicators**: Visual badges and ratings
- **Navigation Arrow**: Right arrow for detail navigation

#### Interaction
- **Tap Card**: Navigate to employee details
- **Pull to Refresh**: Reload employee list
- **Scroll to Load**: Automatic pagination

### Search Screen

#### Search Interface
- **Search Bar**: Prominent search field at top
- **Real-time Results**: Instant feedback as you type
- **Empty State**: Helpful message when no search query
- **No Results**: Clear message when no matches found
- **Loading Indicator**: Visual feedback during search

#### Search Behavior
- **Debounced**: Waits 500ms after typing to search
- **Partial Matching**: Finds partial name or ID matches
- **Case Insensitive**: Search ignores case
- **Auto-focus**: Search field focuses when screen opens

### Employee Details Screen

#### Profile Section
- **Large Profile Image**: High-quality display
- **Fallback Icon**: Person icon when no image available
- **Background**: Gradient background matching app theme

#### Information Sections
- **Contact Information**: Name, Email, Phone
- **Personal Details**: Gender, Address, Company
- **Professional Details**: Employee ID, Joining Date, Years Worked
- **Performance**: Rating with star display
- **Status**: Active/Inactive with visual indicators

#### Special Features
- **Veteran Badge**: Special recognition for long-serving active employees
- **Formatted Dates**: Human-readable date formats
- **Gender Formatting**: Proper capitalization (Male/Female/Other)
- **Address Display**: Multi-line address formatting

## Technical Architecture

### Project Structure
```
zylu_employees_flutter/
├── lib/
│   ├── components/
│   │   ├── employee_card.dart      # Reusable employee card widget
│   │   └── search_bar.dart         # Search bar component
│   ├── controllers/
│   │   └── user_controller.dart    # State management with GetX
│   ├── models/
│   │   └── user_model.dart         # User data model
│   ├── screens/
│   │   ├── home_screen.dart        # Employee list screen
│   │   ├── search_screen.dart      # Search functionality
│   │   ├── employee_details_screen.dart  # Employee details
│   │   └── main_tab_screen.dart    # Bottom navigation
│   ├── app_colors.dart             # App color scheme
│   ├── constants.dart              # API endpoints and constants
│   └── main.dart                   # App entry point
├── assets/
│   └── images/
│       └── star.png                # Rating star icon
└── pubspec.yaml                    # Dependencies and configuration
```

### Key Dependencies
- **get**: State management and navigation
- **http**: HTTP requests to backend API
- **cached_network_image**: Profile image caching
- **flutter/material.dart**: Material Design components

### API Integration
- **Base URL**: Configurable backend endpoint
- **Endpoints**:
  - `/api/mobile/users` - Paginated user list
  - `/api/mobile/users/{id}` - Single user details
  - `/api/mobile/search?q={query}` - Search functionality
- **Error Handling**: Comprehensive error states and messages
- **Caching**: Image caching for better performance

## Development Commands

### Essential Flutter Commands
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run

# Build for release
flutter build apk --release
flutter build ios --release

# Analyze code
flutter analyze

# Run tests
flutter test

# Format code
flutter format .
```

### Development Tools
```bash
# Check connected devices
flutter devices

# Hot reload (while running)
# Press 'r' in terminal

# Hot restart (while running)
# Press 'R' in terminal

# Quit (while running)
# Press 'q' in terminal
```

## Troubleshooting

### Common Issues & Solutions

#### Backend Connection Issues
```bash
# Problem: API calls failing
# Solution: Check backend connection
curl http://localhost:8000/api/mobile/users

# For Android emulator, ensure port forwarding
adb reverse tcp:8000 tcp:8000

# For physical devices, check network connectivity
# Update constants.dart with correct IP address
```

#### Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check for dependency conflicts
flutter pub deps

# Update dependencies
flutter pub upgrade
```

#### Emulator Issues
```bash
# List available emulators
flutter emulators

# Start specific emulator
flutter emulators --launch <emulator_name>

# Cold boot emulator
# Restart Android Studio and emulator
```

#### Performance Issues
```bash
# Run in profile mode for performance analysis
flutter run --profile

# Check memory usage
flutter run --debug
# Use Flutter Inspector in Android Studio
```

### Error Messages & Solutions

1. **"Connection refused"**
   - Ensure Laravel backend is running on port 8000
   - Check port forwarding for Android emulator
   - Verify network connectivity for physical devices

2. **"No connected devices"**
   - Start Android emulator or connect physical device
   - Enable USB debugging on physical devices
   - Check device recognition with `flutter devices`

3. **"Gradle build failed"**
   - Run `flutter clean` and `flutter pub get`
   - Check Android SDK installation
   - Update Gradle wrapper if needed

4. **"Image loading failed"**
   - Check backend storage link: `php artisan storage:link`
   - Verify image permissions on backend
   - Check network connectivity

## Performance Optimization

### Image Optimization
- **Caching**: Cached network images for faster loading
- **Fallback**: Elegant fallback for missing images
- **Compression**: Backend handles image compression

### Search Optimization
- **Debouncing**: Reduces API calls during typing
- **Caching**: Search results cached for better UX
- **Lazy Loading**: Results loaded as needed

### Memory Management
- **Pagination**: Limits data loaded at once
- **Disposal**: Proper widget disposal
- **State Management**: Efficient state updates with GetX

## Production Deployment

### Android Release Build
```bash
# Build release APK
flutter build apk --release

# Build app bundle for Play Store
flutter build appbundle --release
```

### iOS Release Build
```bash
# Build iOS release
flutter build ios --release

# Use Xcode for App Store submission
open ios/Runner.xcworkspace
```

### Release Checklist
- [ ] Update app version in pubspec.yaml
- [ ] Update app icons and splash screens
- [ ] Configure production API URL
- [ ] Test on real devices
- [ ] Verify performance and memory usage
- [ ] Test all user flows

## Security Considerations

- **API Security**: All API calls to trusted backend
- **Data Validation**: Input validation on both client and server
- **Image Security**: Profile images validated on backend
- **Network Security**: HTTPS recommended for production
- **Local Storage**: No sensitive data stored locally

## Future Enhancements

- **Offline Mode**: Cache employee data for offline viewing
- **Push Notifications**: Real-time updates for employee changes
- **Advanced Filters**: Filter by department, rating, status
- **Employee Actions**: Edit employee information from mobile
- **Analytics**: Usage tracking and insights
- **Multi-language**: Support for multiple languages

---

**Note**: This Flutter application requires the Laravel backend to be running. Ensure both the backend server and mobile app are properly configured for optimal functionality.
