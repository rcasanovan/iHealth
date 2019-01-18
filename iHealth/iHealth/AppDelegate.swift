//
//  AppDelegate.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureReachability()
        configureNavigationBar()
        configShareMessage()
        configureTabBar()
        showInitialView()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

//MARK: - Navigation methods
extension AppDelegate  {
    
    private func showInitialView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainTabBar = MainTabBar()
        
        self.window?.rootViewController = mainTabBar
        self.window?.makeKeyAndVisible()
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .blackOpaque
    }
    
    private func configureTabBar() {
        UITabBar.appearance().barTintColor = .black
    }
    
}

//MARK: - Reachability
extension AppDelegate {
    
    private func configureReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange), name: NSNotification.Name.reachabilityChanged, object: nil)
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
    }
    
    @objc private func handleNetworkChange() {
        if LocalGoalManager.shared.isEmpty() && !ReachabilityManager.shared.hasConnection() {
            showReachabilityMessage(true)
            return
        }
        
        showReachabilityMessage(false)
    }
    
    /**
     * Show reachability message
     *
     * - parameters:
     *      -show: show / hide reachability message
     */
    private func showReachabilityMessage(_ show: Bool) {
        guard let rootViewController = UIApplication.shared.windows[0].rootViewController else {
            return
        }
        
        if show, let _ = rootViewController.presentedViewController as? GeneralMessageViewController {
            return
        }
        
        if show {
            let generalMessageViewController = GeneralMessageViewController()
            generalMessageViewController.modalTransitionStyle = .coverVertical
            generalMessageViewController.modalPresentationStyle = .overCurrentContext
            generalMessageViewController.presenter = GeneralMessagePresenter(view: generalMessageViewController, type: .NoInternetConnection)
            rootViewController.present(generalMessageViewController, animated: true, completion: nil)
        } else {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension AppDelegate {
    
    public func configShareMessage() {
        ShareManager.shared.setup(defaultShareMessage: "🏃🏻‍♂️ Hey!. Check my progress with this amazing app!. You can check the project here: https://github.com/rcasanovan/iHealth")
    }
    
}
