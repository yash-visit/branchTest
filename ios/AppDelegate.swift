// //
// //  AppDelegate.swift
// //  branchTest
// //

import UIKit

@UIApplicationMain
  class AppDelegate : UIResponder, UIApplicationDelegate, RCTBridgeDelegate  {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
//        #if DEBUG
            return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
//        #else
//            return Bundle.main.url(forResource:"main", withExtension:"jsbundle")
//        #endif
    }
      var window: UIWindow?
      var bridge: RCTBridge!
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          self.bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
          // let jsCodeLocation: URL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource:nil)
          // let rootView = RCTRootView(
          //   bundleURL: jsCodeLocation,
          //     moduleName: "branchTest",
          //     initialProperties: nil,
          //     launchOptions: launchOptions)
          let rootView = RCTRootView(bridge: self.bridge, moduleName: "branchTest", initialProperties: nil)

           #if DEBUG
              RNBranch.useTestInstance()
           #endif
        
          RNBranch.initSession(launchOptions: launchOptions, isReferrable: true) // <-- add this


          let rootViewController = UIViewController()
          rootViewController.view = rootView
          self.window = UIWindow(frame: UIScreen.main.bounds)
          self.window!.rootViewController = rootViewController;
          self.window!.makeKeyAndVisible()
          return true
      }
    
    // Add the openURL and continueUserActivity functions
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      return RNBranch.application(app, open:url, options:options)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
      return RNBranch.continue(userActivity)
    }
    
  }
