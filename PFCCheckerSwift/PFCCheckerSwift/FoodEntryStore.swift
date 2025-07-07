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
        let request: NSFetchRequest<FoodEntry> = FoodEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FoodEntry.timestamp, ascending: false)]
        
        do {
            foodEntries = try viewContext.fetch(request)
        } catch {
            print("Error fetching food entries: \(error)")
        }
    }
    
    func addFoodEntry(food: Food, quantity: Int16) {
        let newEntry = FoodEntry(context: viewContext)
        newEntry.food = food
        newEntry.quantity = quantity
        newEntry.timestamp = Date()
        
        saveContext()
    }
    
    func deleteFoodEntry(_ foodEntry: FoodEntry) {
        viewContext.delete(foodEntry)
        saveContext()
    }
    
    func getTodayEntries() -> [FoodEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        return foodEntries.filter { entry in
            guard let timestamp = entry.timestamp else { return false }
            return timestamp >= today && timestamp < tomorrow
        }
    }
    
    func getTotalPFC() -> (protein: Double, fat: Double, carb: Double, calorie: Double) {
        let todayEntries = getTodayEntries()
        var totalP = 0.0
        var totalF = 0.0
        var totalC = 0.0
        var totalK = 0.0
        
        for entry in todayEntries {
            guard let food = entry.food else { continue }
            let quantity = Double(entry.quantity)
            
            totalP += food.protein * quantity / 100.0
            totalF += food.fat * quantity / 100.0
            totalC += food.carb * quantity / 100.0
            totalK += food.calorie * quantity / 100.0
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