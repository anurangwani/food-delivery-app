# Stellar
Flutter food application
Prerequisites:
Flutter SDK: Make sure you have Flutter SDK installed on your machine. If not, you can download it from the Flutter official website.
Android Studio: Install Android Studio and set it up with the necessary SDKs.
Steps to Run the Flutter App on Android Emulator:
Launch Android Studio:
Open Android Studio and wait for it to fully load.
Open AVD Manager:
Click on AVD Manager icon (it looks like a little Android with a phone) on the toolbar or navigate to Tools > AVD Manager from the top menu.
Create Virtual Device:
In the AVD Manager window, click on Create Virtual Device.
Choose a hardware profile (e.g., Pixel 5, Pixel 4, etc.) and click Next.
Select a system image. It's recommended to choose one with the Play Store if you want to test apps that require it.
Click Next, give your device a name, and click Finish.
Start the Emulator:
In the AVD Manager, click the Play button next to the emulator you just created. This will launch the Android emulator.
Navigate to Your Flutter Project Directory:
cd path/to/your/flutter_project
Run the App:
flutter run
Flutter will build the app and install it on the running emulator. The app should launch automatically on the emulator once the installation is complete.
