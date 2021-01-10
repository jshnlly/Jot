//
//  JotApp.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

@main
struct JotApp: App {
    @AppStorage("darkMode") private var darkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
