//
//  UserSettings.swift
//  Jot
//
//  Created by Josh Nelson on 1/10/21.
//

import Foundation
import Combine

//Creates the functionality for the titleview toggle to be saved as an input when user clears / refreshes the app

class UserSettings: ObservableObject {
    @Published var titleView: Bool {
        didSet {
            UserDefaults.standard.set(titleView, forKey: "titleView")
        }
        }
    
    init() {
        titleView = UserDefaults.standard.object(forKey: "titleView") as? Bool ?? true
    }
}
