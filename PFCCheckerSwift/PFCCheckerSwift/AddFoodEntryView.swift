import SwiftUI

struct AddFoodEntryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var foodStore: FoodStore
    @EnvironmentObject var foodEntryStore: FoodEntryStore

    @State private var selectedFood: Food? 
    @State private var quantity: Int16 = 100

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("食品を選択")) {
                    Picker("食品", selection: $selectedFood) {
                        ForEach(foodStore.foods, id: \.self) { food in
                            Text(food.name ?? "無名").tag(food as Food?)
                        }
                    }
                    .onAppear {
                        if selectedFood == nil {
                            selectedFood = foodStore.foods.first
                        }
                    }
                }

                Section(header: Text("量 (g)")) {
                    Stepper(value: $quantity, in: 1...1000, step: 10) {
                        Text("\(quantity) g")
                    }
                }

                Section {
                    Button("追加") {
                        guard let food = selectedFood else { return }
                        foodEntryStore.addFoodEntry(food: food, quantity: quantity)
                        dismiss()
                    }
                    .disabled(selectedFood == nil)
                }
            }
            .navigationTitle("食事を追加")
            .navigationBarItems(leading: Button("キャンセル") {
                dismiss()
            })
        }
    }
}