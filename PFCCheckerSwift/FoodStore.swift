import Foundation
import SwiftUI

class FoodStore: ObservableObject {
    @Published var todayEntries: [FoodEntry] = []
    @Published var recentFoods: [Food] = []
    
    private let userDefaults = UserDefaults.standard
    private let savedDateKey = "savedDate"
    private let entriesKey = "todayEntries"
    private let recentFoodsKey = "recentFoods"
    
    // 目標値 (ハードコード)
    let targetP: Double = 120.0
    let targetF: Double = 70.0
    let targetC: Double = 250.0
    let targetK: Double = 2000.0
    
    init() {
        loadData()
        checkAndResetIfNewDay()
    }
    
    // 今日の合計値を計算
    var totalP: Double {
        todayEntries.reduce(0) { $0 + $1.totalP }
    }
    
    var totalF: Double {
        todayEntries.reduce(0) { $0 + $1.totalF }
    }
    
    var totalC: Double {
        todayEntries.reduce(0) { $0 + $1.totalC }
    }
    
    var totalK: Double {
        todayEntries.reduce(0) { $0 + $1.totalK }
    }
    
    // 進捗率を計算
    var progressP: Double {
        min(totalP / targetP, 1.0)
    }
    
    var progressF: Double {
        min(totalF / targetF, 1.0)
    }
    
    var progressC: Double {
        min(totalC / targetC, 1.0)
    }
    
    var progressK: Double {
        min(totalK / targetK, 1.0)
    }
    
    // 食材を追加
    func addFood(_ food: Food) {
        let newEntry = FoodEntry(food: food)
        todayEntries.append(newEntry)
        updateRecentFoods(food)
        saveData()
    }
    
    // 最近の食材を更新 (最大5件)
    private func updateRecentFoods(_ food: Food) {
        recentFoods.removeAll { $0.name == food.name }
        recentFoods.insert(food, at: 0)
        if recentFoods.count > 5 {
            recentFoods.removeLast()
        }
    }
    
    // データを読み込み
    private func loadData() {
        if let entriesData = userDefaults.data(forKey: entriesKey),
           let entries = try? JSONDecoder().decode([FoodEntry].self, from: entriesData) {
            todayEntries = entries
        }
        
        if let recentData = userDefaults.data(forKey: recentFoodsKey),
           let recent = try? JSONDecoder().decode([Food].self, from: recentData) {
            recentFoods = recent
        } else {
            recentFoods = Food.defaultFoods
        }
    }
    
    // データを保存
    private func saveData() {
        if let entriesData = try? JSONEncoder().encode(todayEntries) {
            userDefaults.set(entriesData, forKey: entriesKey)
        }
        
        if let recentData = try? JSONEncoder().encode(recentFoods) {
            userDefaults.set(recentData, forKey: recentFoodsKey)
        }
        
        userDefaults.set(Date(), forKey: savedDateKey)
    }
    
    // 日付チェックして新しい日ならリセット
    private func checkAndResetIfNewDay() {
        let calendar = Calendar.current
        let today = Date()
        
        if let savedDate = userDefaults.object(forKey: savedDateKey) as? Date {
            if !calendar.isDate(savedDate, inSameDayAs: today) {
                resetTodayData()
            }
        } else {
            resetTodayData()
        }
    }
    
    // 今日のデータをリセット
    private func resetTodayData() {
        todayEntries = []
        saveData()
    }
}