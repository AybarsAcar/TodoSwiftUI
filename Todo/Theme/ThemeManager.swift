//
//  ThemeSettings.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import Foundation
import SwiftUI

///
/// make it a singleton
///
class ThemeManager: ObservableObject {
  
  public static let shared = ThemeManager()
  
  private init() {}
  
  @Published var themeValue: Int = UserDefaults.standard.integer(forKey: "Theme") {
    
    didSet {
      UserDefaults.standard.set(self.themeValue, forKey: "Theme")
    }
  }
}
