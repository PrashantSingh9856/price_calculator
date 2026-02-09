# App Icon Setup Instructions

## Current Status
✅ App name changed to "PriceCalculator"
✅ Icon configuration added to pubspec.yaml
✅ Assets folder created at `assets/icon/`

## Next Steps - Create Your App Icon

### Option 1: Use an Online Icon Generator (Recommended)
1. Visit: https://icon.kitchen/ or https://appicon.co/
2. Create a simple calculator icon with these colors:
   - Background: #0E1117 (dark)
   - Icon color: Blue (#3B82F6) to Purple (#8B5CF6) gradient
3. Download the icon as PNG (1024x1024 recommended)
4. Save it as `app_icon.png` in `assets/icon/` folder
5. Also save a foreground version (transparent background) as `app_icon_foreground.png`

### Option 2: Use a Simple Icon
1. Find any calculator icon online (PNG format, 1024x1024)
2. Save as `app_icon.png` in `assets/icon/` folder
3. Copy the same file as `app_icon_foreground.png`

### After Adding the Icon Files

Run these commands:
```bash
# Install dependencies
flutter pub get

# Generate the app icons
flutter pub run flutter_launcher_icons

# Rebuild the APK
flutter build apk --release
```

## Icon File Locations
- Main icon: `assets/icon/app_icon.png`
- Foreground (adaptive): `assets/icon/app_icon_foreground.png`

The new APK will have:
- App name: **PriceCalculator**
- Custom app icon (once you add the PNG files)
