import Foundation
import CoreData

class FoodStore: ObservableObject {
    @Published var foods: [Food] = []
    private let viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchFoods()
    }

    func fetchFoods() {
        let request: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FoodEntity.name, ascending: true)]

        do {
            let fetchedEntities = try viewContext.fetch(request)
            self.foods = fetchedEntities.map { entity in
                Food(id: entity.objectID.uriRepresentation().uuid(),
                     name: entity.name ?? "",
                     protein: entity.protein,
                     fat: entity.fat,
                     carbs: entity.carbs,
                     calories: entity.calories)
            }
        } catch {
            print("Error fetching foods: \(error)")
        }
    }

    func addFood(name: String, protein: Double, fat: Double, carbs: Double, calories: Double) {
        let newFoodEntity = FoodEntity(context: viewContext)
        newFoodEntity.name = name
        newFoodEntity.protein = protein
        newFoodEntity.fat = fat
        newFoodEntity.carbs = carbs
        newFoodEntity.calories = calories

        saveContext()
    }

    func deleteFood(_ food: Food) {
        let request: NSFetchRequest<FoodEntity> = FoodEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", food.name)
        do {
            let fetchedEntities = try viewContext.fetch(request)
            if let entityToDelete = fetchedEntities.first {
                viewContext.delete(entityToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting food: \(error)")
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
            fetchFoods() // 保存後に再フェッチしてUIを更新
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

extension URL {
    func uuid() -> UUID {
        UUID(uuidString: lastPathComponent) ?? UUID()
    }
}
