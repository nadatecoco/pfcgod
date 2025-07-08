import CoreData
import SwiftUI

class FoodEntryStore: ObservableObject {
    @Published var foodEntries: [FoodEntry] = []
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchFoodEntries()
    }
    
    func fetchFoodEntries() {
        let request: NSFetchRequest<FoodEntryEntity> = FoodEntryEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FoodEntryEntity.timestamp, ascending: false)]
        
        do {
            let fetchedEntities = try viewContext.fetch(request)
            self.foodEntries = fetchedEntities.map { entity in
                // FoodEntityからFood structへの変換
                let food = Food(id: entity.food?.objectID.uriRepresentation().uuid() ?? UUID(),
                                name: entity.food?.name ?? "",
                                protein: entity.food?.protein ?? 0,
                                fat: entity.food?.fat ?? 0,
                                carbs: entity.food?.carbs ?? 0,
                                calories: entity.food?.calories ?? 0)
                
                return FoodEntry(id: entity.objectID.uriRepresentation().uuid(),
                                 food: food,
                                 quantity: entity.quantity,
                                 timestamp: entity.timestamp ?? Date())
            }
        } catch {
            print("Error fetching food entries: \(error)")
        }
    }
    
    func addFoodEntry(food: Food, quantity: Int16) {
        let newEntryEntity = FoodEntryEntity(context: viewContext)
        
        // Food structから対応するFoodEntityを検索して関連付ける
        let foodRequest: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
        foodRequest.predicate = NSPredicate(format: "name == %@", food.name)
        
        do {
            let fetchedFoods = try viewContext.fetch(foodRequest)
            if let foodEntity = fetchedFoods.first {
                newEntryEntity.food = foodEntity
                newEntryEntity.quantity = quantity
                newEntryEntity.timestamp = Date()
                
                saveContext()
            } else {
                print("Error: Food entity not found for name \(food.name)")
            }
        } catch {
            print("Error fetching food entity for addFoodEntry: \(error)")
        }
    }
    
    func deleteFoodEntry(_ foodEntry: FoodEntry) {
        let request: NSFetchRequest<FoodEntryEntity> = FoodEntryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "timestamp == %@ AND quantity == %d", foodEntry.timestamp as NSDate, foodEntry.quantity)
        
        do {
            let fetchedEntities = try viewContext.fetch(request)
            if let entityToDelete = fetchedEntities.first {
                viewContext.delete(entityToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting food entry: \(error)")
        }
    }
    
    func getTodayEntries() -> [FoodEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        return foodEntries.filter { entry in
            return entry.timestamp >= today && entry.timestamp < tomorrow
        }
    }
    
    func getTotalPFC() -> (protein: Double, fat: Double, carb: Double, calorie: Double) {
        let todayEntries = getTodayEntries()
        var totalP = 0.0
        var totalF = 0.0
        var totalC = 0.0
        var totalK = 0.0
        
        for entry in todayEntries {
            totalP += entry.food.protein
            totalF += entry.food.fat
            totalC += entry.food.carbs
            totalK += entry.food.calories
        }
        
        return (totalP, totalF, totalC, totalK)
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchFoodEntries()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
