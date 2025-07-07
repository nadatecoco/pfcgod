import CoreData
import SwiftUI

class FoodStore: ObservableObject {
    @Published var foods: [Food] = []
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchFoods()
    }
    
    func fetchFoods() {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Food.name, ascending: true)]
        
        do {
            foods = try viewContext.fetch(request)
        } catch {
            print("Error fetching foods: \(error)")
        }
    }
    
    func addFood(name: String, protein: Double, fat: Double, carb: Double, calorie: Double) {
        let newFood = Food(context: viewContext)
        newFood.name = name
        newFood.protein = protein
        newFood.fat = fat
        newFood.carb = carb
        newFood.calorie = calorie
        
        saveContext()
    }
    
    func deleteFood(_ food: Food) {
        viewContext.delete(food)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchFoods()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}