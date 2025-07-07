import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // サンプルデータを作成
        let sampleFood = Food(context: viewContext)
        sampleFood.name = "チキン胸肉"
        sampleFood.protein = 22.3
        sampleFood.fat = 1.5
        sampleFood.carb = 0.0
        sampleFood.calorie = 108.0
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Preview error: \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}