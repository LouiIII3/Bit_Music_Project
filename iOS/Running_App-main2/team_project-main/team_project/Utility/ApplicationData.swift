//
//  CoreData.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import Foundation
import CoreData

class ApplicationData: ObservableObject {
   let container: NSPersistentContainer

   static var preview: ApplicationData = {
      let model = ApplicationData(preview: true)
      return model
   }()

   init(preview: Bool = false) {
      container = NSPersistentContainer(name: "CustomRoutine")
      if preview {
         container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
   }
    
}
