import Foundation
import CoreData

extension FoodEntry {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntry> {
        NSFetchRequest<FoodEntry>(entityName: "FoodEntry")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var timestamp: Date?
    @NSManaged public var food: Food?
}