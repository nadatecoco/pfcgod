// PFCCheckerSwift/ViewModels/FoodViewModel.swift

import Foundation
import Combine

@MainActor
class FoodViewModel: ObservableObject {
    @Published var quickFoods: [Food] = []
    @Published var todaysEntries: [FoodEntry] = []

    private let quickFoodsKey = "quickFoods"
    private let foodEntriesKey = "foodEntries"

    // MARK: - Computed Properties for UI
    var totalProtein: Double {
        todaysEntries.reduce(0) { $0 + $1.food.protein }
    }
    var totalFat: Double {
        todaysEntries.reduce(0) { $0 + $1.food.fat }
    }
    var totalCarbs: Double {
        todaysEntries.reduce(0) { $0 + $1.food.carbs }
    }
    var totalCalories: Double {
        todaysEntries.reduce(0) { $0 + $1.food.calories }
    }

    init() {
        loadQuickFoods()
        loadTodaysEntries()
    }

    // MARK: - User Actions
    func addFoodEntry(for food: Food) {
        let newEntry = FoodEntry(food: food)
        todaysEntries.append(newEntry)
        saveTodaysEntries()
    }
    
    // IndexSetを使う既存のメソッド
    func deleteEntry(at offsets: IndexSet) {
        todaysEntries.remove(atOffsets: offsets)
        saveTodaysEntries()
    }
    
    // IDを指定して削除する新しいメソッド
    func deleteEntry(id: UUID) {
        todaysEntries.removeAll { $0.id == id }
        saveTodaysEntries()
    }

    // MARK: - Data Persistence (UserDefaults)
    private func loadQuickFoods() {
        if let data = UserDefaults.standard.data(forKey: quickFoodsKey),
           let decodedFoods = try? JSONDecoder().decode([Food].self, from: data),
           !decodedFoods.isEmpty {
            self.quickFoods = decodedFoods
        } else {
            setupInitialFoods()
        }
    }
    
    private func loadTodaysEntries() {
        if let data = UserDefaults.standard.data(forKey: foodEntriesKey),
           let allEntries = try? JSONDecoder().decode([FoodEntry].self, from: data) {
            self.todaysEntries = allEntries.filter { Calendar.current.isDateInToday($0.date) }
        }
    }

    private func saveTodaysEntries() {
        var allEntries: [FoodEntry] = []
        if let data = UserDefaults.standard.data(forKey: foodEntriesKey),
           let decodedEntries = try? JSONDecoder().decode([FoodEntry].self, from: data) {
            allEntries = decodedEntries.filter { !Calendar.current.isDateInToday($0.date) }
        }
        allEntries.append(contentsOf: todaysEntries)
        
        if let encoded = try? JSONEncoder().encode(allEntries) {
            UserDefaults.standard.set(encoded, forKey: foodEntriesKey)
        }
    }
    
    private func saveQuickFoods() {
        if let encoded = try? JSONEncoder().encode(quickFoods) {
            UserDefaults.standard.set(encoded, forKey: quickFoodsKey)
        }
    }

    private func setupInitialFoods() {
        self.quickFoods = [
            // 既存
            Food(name: "鶏むね肉", protein: 23, fat: 1.9, carbs: 0, calories: 120),
            Food(name: "卵", protein: 6.2, fat: 5.2, carbs: 0.2, calories: 91),
            Food(name: "ブロッコリー", protein: 3.6, fat: 0.4, carbs: 7.2, calories: 37),
            Food(name: "ごはん", protein: 2.5, fat: 0.3, carbs: 37.1, calories: 156),
            Food(name: "バナナ", protein: 1.1, fat: 0.2, carbs: 22.5, calories: 93),
            // 追加
            Food(name: "ささみ", protein: 23, fat: 0.8, carbs: 0, calories: 105),
            Food(name: "オートミール", protein: 13, fat: 6, carbs: 60, calories: 380),
            Food(name: "ギリシャヨーグルト", protein: 10, fat: 5, carbs: 4, calories: 100),
            Food(name: "鮭", protein: 20, fat: 13, carbs: 0, calories: 205),
            Food(name: "アーモンド", protein: 21, fat: 50, carbs: 22, calories: 575),
            Food(name: "豆腐", protein: 8, fat: 5, carbs: 2, calories: 80),
            Food(name: "牛乳", protein: 3.3, fat: 3.8, carbs: 5, calories: 67),
            Food(name: "チーズ", protein: 25, fat: 33, carbs: 1.3, calories: 402),
            Food(name: "納豆", protein: 16, fat: 10, carbs: 12, calories: 200),
            Food(name: "りんご", protein: 0.3, fat: 0.2, carbs: 14, calories: 52)
        ]
        saveQuickFoods()
    }
}