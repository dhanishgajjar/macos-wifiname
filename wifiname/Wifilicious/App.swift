//
//  App.swift
//  wifiname
//
//  Created by Brian Clark on 12/27/17.
//  Copyright © 2024 Clarkio. All rights reserved.
//  www.clarkio.com

import SwiftUI
import CoreWLAN
import CoreLocation

@main
struct Wifiname: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    static private (set) var instance: AppDelegate?
    
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let locationManager = CLLocationManager()
    let wifiClient = CWWiFiClient.shared()
    var visible = true
    
    let prompt = Prompt()
    
    let forDeniedRestricted = "To continue, please enable Location Services on your device. You can do this by going to your privacy settings. Without Location Services, we can't access the SSID (Wi-Fi network name) information we need to provide you with the best experience. It's a requirement from Apple, not us"
    
    let forUndetermined = "To use Wifilicious, please enable Location Services. This is necessary for the app to function. Go to your settings and allow location access to get started."
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        locationManager.delegate = self
        AppDelegate.instance = self
        checkAuthorizationStatus()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        do {
            try wifiClient.stopMonitoringEvent(with: .ssidDidChange)
        } catch {
            print(error.localizedDescription)
        }
    }
}
