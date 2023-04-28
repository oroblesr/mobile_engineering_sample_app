import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*10))
    WorkmanagerPlugin.registerTask(withIdentifier: "com.example.mobile_engineering_sample_app.fetch_news")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
