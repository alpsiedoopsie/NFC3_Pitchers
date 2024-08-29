import UIKit
import Flutter
import background_fetch

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Safely unwrap the registrar
    if let registrar = self.registrar(forPlugin: "com.transistorsoft/flutter_background_fetch") {
      BackgroundFetchPlugin.register(with: registrar)
    } else {
      print("Failed to register BackgroundFetchPlugin")
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}