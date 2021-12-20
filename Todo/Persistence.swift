//
//  Persistence.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import CoreData

struct PersistenceController {
  
  static let shared = PersistenceController()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Todo")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
  
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for i in 0..<10 {
      let newItem = TodoItem(context: viewContext)
      newItem.name = "Todo Item \(i)"
      newItem.priority = "Normal"
      newItem.id = UUID()
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
