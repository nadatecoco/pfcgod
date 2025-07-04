import Foundation

struct Food: Identifiable, Codable {
    let id = UUID()
    let name: String
    let servingP: Double   // 1食分のプロテイン (g)
    let servingF: Double   // 1食分の脂質 (g)
    let servingC: Double   // 1食分の炭水化物 (g)
    let servingK: Double   // 1食分のカロリー (kcal)
    
    init(name: String, servingP: Double, servingF: Double, servingC: Double, servingK: Double) {
        self.name = name
        self.servingP = servingP
        self.servingF = servingF
        self.servingC = servingC
        self.servingK = servingK
    }
}

extension Food {
    static let defaultFoods = [
        Food(name: "鶏むね肉", servingP: 23.0, servingF: 1.9, servingC: 0.0, servingK: 120.0),
        Food(name: "卵", servingP: 6.2, servingF: 5.2, servingC: 0.2, servingK: 91.0),
        Food(name: "ブロッコリー", servingP: 3.6, servingF: 0.4, servingC: 7.2, servingK: 37.0),
        Food(name: "ごはん", servingP: 2.5, servingF: 0.3, servingC: 37.1, servingK: 156.0),
        Food(name: "バナナ", servingP: 1.1, servingF: 0.2, servingC: 22.5, servingK: 93.0)
    ]
}

struct FoodEntry: Identifiable, Codable {
    let id = UUID()
    let food: Food
    let count: Int
    let timestamp: Date
    
    init(food: Food, count: Int = 1) {
        self.food = food
        self.count = count
        self.timestamp = Date()
    }
    
    var totalP: Double { food.servingP * Double(count) }
    var totalF: Double { food.servingF * Double(count) }
    var totalC: Double { food.servingC * Double(count) }
    var totalK: Double { food.servingK * Double(count) }
}