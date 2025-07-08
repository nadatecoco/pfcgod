import Foundation
import CoreData

extension Food {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var name: String?
    @NSManaged public var protein: Double
    @NSManaged public var fat: Double
    @NSManaged public var carbs: Double
    @NSManaged public var calories: Double
    @NSManaged public var entries: NSSet?
}