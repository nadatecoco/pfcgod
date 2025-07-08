import Foundation

struct Food: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var protein: Double
    var fat: Double
    var carbs: Double
    var calories: Double

    init(id: UUID = UUID(), name: String, protein: Double, fat: Double, carbs: Double, calories: Double) {
        self.id = id
        self.name = name
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.calories = calories
    }
}

struct FoodEntry: Identifiable, Codable {
    let id: UUID
    let food: Food
    let quantity: Int16
    let timestamp: Date

    init(id: UUID = UUID(), food: Food, quantity: Int16, timestamp: Date = Date()) {
        self.id = id
        self.food = food
        self.quantity = quantity
        self.timestamp = timestamp
    }
}