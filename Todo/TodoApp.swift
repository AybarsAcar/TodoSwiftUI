//
//  TodoApp.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI

@main
struct TodoApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(AppIconManager())
    }
  }
}
