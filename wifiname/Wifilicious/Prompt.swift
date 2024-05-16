//
//  Prompt.swift
//  wifiname
//
//  Created by Dhanish on 16/05/2024.
//  Copyright © 2024 Clarkio. All rights reserved.
//

import SwiftUI

class Prompt {
    var isPromptingLocationServices = false

    func toEnableLocationServices() {
        
        guard !isPromptingLocationServices else { return }
        isPromptingLocationServices = true
        
        let alert = NSAlert()
        alert.messageText = "Location Services Disabled"
        alert.informativeText = "SSID information is not available unless Location Services is enabled"
        alert.addButton(withTitle: "Open System Preferences")
        alert.addButton(withTitle: "Cancel")
        
        if alert.runModal() == .alertFirstButtonReturn,
           let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices") {
            NSWorkspace.shared.open(url)
        }
        
        isPromptingLocationServices = false
    }
}
