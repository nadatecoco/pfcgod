import SwiftUI
import CoreData

@main
struct PFCCheckerSwiftApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var foodStore: FoodStore
    @StateObject var foodEntryStore: FoodEntryStore

    init() {
        let context = persistenceController.container.viewContext
        _foodStore = StateObject(wrappedValue: FoodStore(viewContext: context))
        _foodEntryStore = StateObject(wrappedValue: FoodEntryStore(viewContext: context))

        // ダミーデータの投入
        if foodStore.foods.isEmpty {
            foodStore.addFood(name: "鶏むね肉", protein: 23.0, fat: 1.9, carbs: 0.0, calories: 120.0)
            foodStore.addFood(name: "卵", protein: 6.2, fat: 5.2, carbs: 0.2, calories: 91.0)
            foodStore.addFood(name: "ブロッコリー", protein: 3.6, fat: 0.4, carbs: 7.2, calories: 37.0)
            foodStore.addFood(name: "ごはん", protein: 2.5, fat: 0.3, carbs: 37.1, calories: 156.0)
            foodStore.addFood(name: "バナナ", protein: 1.1, fat: 0.2, carbs: 22.5, calories: 93.0)
            foodStore.addFood(name: "ささみ", protein: 23.0, fat: 0.8, carbs: 0.0, calories: 105.0)
            foodStore.addFood(name: "オートミール", protein: 13.0, fat: 6.0, carbs: 60.0, calories: 380.0)
            foodStore.addFood(name: "ギリシャヨーグルト", protein: 10.0, fat: 5.0, carbs: 4.0, calories: 100.0)
            foodStore.addFood(name: "鮭", protein: 20.0, fat: 13.0, carbs: 0.0, calories: 205.0)
            foodStore.addFood(name: "アーモンド", protein: 21.0, fat: 50.0, carbs: 22.0, calories: 575.0)
            foodStore.addFood(name: "豆腐", protein: 8.0, fat: 5.0, carbs: 2.0, calories: 80.0)
            foodStore.addFood(name: "牛乳", protein: 3.3, fat: 3.8, carbs: 5.0, calories: 67.0)
            foodStore.addFood(name: "チーズ", protein: 25.0, fat: 33.0, carbs: 1.3, calories: 402.0)
            foodStore.addFood(name: "納豆", protein: 16.0, fat: 10.0, carbs: 12.0, calories: 200.0)
            foodStore.addFood(name: "りんご", protein: 0.3, fat: 0.2, carbs: 14.0, calories: 52.0)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(foodStore)
                .environmentObject(foodEntryStore)
        }
    }
}