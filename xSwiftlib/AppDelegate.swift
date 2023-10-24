

import UIKit
import xTracking
import QMUIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //  初始化 InjectionIII
        Bundle.init(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: MainController.init())
        window?.makeKeyAndVisible()
        
        TKExposeTracking.shared().registExposeEventLifeIndicator(self) { view, expose, isInBackground in
            print("expose: \(expose.trackingId ?? "null")")
        }
        TKExposeTracking.shared().exposeValidSizePercentage = 0.1
        TKExposeTracking.shared().start()
        
        return true
    }
}
