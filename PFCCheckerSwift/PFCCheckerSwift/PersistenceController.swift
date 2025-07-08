import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Model") // .xcdatamodeld のファイル名に合わせる
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }

  var viewContext: NSManagedObjectContext { container.viewContext }
}
