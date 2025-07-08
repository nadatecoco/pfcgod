import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var foodStore: FoodStore
    @EnvironmentObject var foodEntryStore: FoodEntryStore

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // --- 上部 40%: 今日の記録 ---
                VStack(alignment: .leading) {
                    Text(String(format: "今日の合計: P %.0fg F %.0fg C %.0fg / %.0f Kcal", foodEntryStore.getTotalPFC().protein, foodEntryStore.getTotalPFC().fat, foodEntryStore.getTotalPFC().carb, foodEntryStore.getTotalPFC().calorie))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    List {
                        ForEach(foodEntryStore.getTodayEntries()) { entry in
                            HStack {
                                Text(entry.food.name)
                                Spacer()
                                Text(String(format: "%.0f kcal", entry.food.calories))
                                    .foregroundStyle(.secondary)
                            }
                            .contentShape(Rectangle()) // タップ領域を広げる
                            .onTapGesture { // タップで削除
                                foodEntryStore.deleteFoodEntry(entry)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .frame(height: geometry.size.height * 0.4)

                // --- 下部 60%: クイック追加 ---
                VStack(alignment: .leading) {
                    Text("クイック追加")
                        .font(.headline)
                        .padding([.top, .horizontal])

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(foodStore.foods) { food in
                                Button(action: {
                                    foodEntryStore.addFoodEntry(food: food, quantity: 100) // quantityは100固定
                                }) {
                                    Text(food.name)
                                        .padding()
                                        .background(Color.blue.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer() // ボタンを上部に集める
                }
                .frame(height: geometry.size.height * 0.6)
                .background(Color.gray.opacity(0.1))
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
