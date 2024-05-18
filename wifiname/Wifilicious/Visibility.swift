//
//  Visibility.swift
//  wifiname
//
//  Created by Dhanish on 16/05/2024.
//  Copyright © 2024 Clarkio. All rights reserved.
//

import SwiftUI

extension AppDelegate {
    
    @objc func toggleVisibility(_ sender: Any?) {
        visible.toggle()
        updateStatusBar()
    }

    func updateStatusBar() {
        guard let button = statusBarItem.button else { return }
        if let ssid = getSSID(), !ssid.isEmpty && visible {
            button.action = #selector(showMenu(_:))
            button.title = ssid
            if let connectedImage = NSImage(named: NSImage.Name("connected")) {
                let newSize = NSSize(width: 22, height: 22)
                connectedImage.size = newSize
                button.image = connectedImage
            }
        } else {
            button.title = visible ? "Disconnected" : "🙈"
            if let disconnectedImage = NSImage(named: NSImage.Name("disconnected")) {
                let newSize = NSSize(width: 22, height: 22)
                disconnectedImage.size = newSize
                button.image = visible ? disconnectedImage : nil
            }
        }
    }
    
    @objc func showMenu(_ sender: Any?) {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: visible ? "Hide" : "Show", action: #selector(toggleVisibility(_:)), keyEquivalent: "t"))
        menu.addItem(NSMenuItem(title: "About", action: #selector(about), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        if let button = statusBarItem.button {
            let buttonFrame = button.frame
            let menuWidth = menu.size.width
            let buttonCenterX = buttonFrame.origin.x + (buttonFrame.size.width / 2)
            let menuOrigin = NSPoint(x: buttonCenterX - (menuWidth / 2), y: buttonFrame.origin.y - buttonFrame.size.height)
            menu.popUp(positioning: nil, at: menuOrigin, in: button.superview)
        }
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
        NSApp.activate(ignoringOtherApps: true)
    }

}
