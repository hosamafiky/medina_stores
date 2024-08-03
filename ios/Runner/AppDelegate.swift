import Flutter
import UIKit
import GoogleMaps
import app_links

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //FIXME: Replace the API key with your own
    GMSServices.provideAPIKey("AIzaSyDV1H2CcIYVHXtndUp8w_tu79A5OgLoAFU")

    // TODO: Uncomment this code to handle screenshots
    // NotificationCenter.default.addObserver(
    //   self,
    //   selector: #selector(didTakeScreenshot),
    //   name: UIApplication.userDidTakeScreenshotNotification,
    //   object: nil
    // )


    GeneratedPluginRegistrant.register(with: self)

    // Retrieve the link from parameters
    if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
      // We have a link, propagate it to your Flutter app or not
      AppLinks.shared.handleLink(url: url)
      return true // Returning true will stop the propagation to other packages
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  //TODO: Uncomment this code to handle screenshots
  // @objc func didTakeScreenshot() {
  //   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  //   let screenshotChannel = FlutterMethodChannel(name: "screenshot_detector",
  //                                                 binaryMessenger: controller.binaryMessenger)
  //   screenshotChannel.invokeMethod("onScreenshot", arguments: nil)
  // }
}
