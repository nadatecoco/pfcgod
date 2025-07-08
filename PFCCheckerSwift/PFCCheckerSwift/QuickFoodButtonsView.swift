//
//  QuickFoodButtonsView.swift
//  PFCCheckerSwift
//

import SwiftUI

struct QuickFoodButtonsView: View {
    @EnvironmentObject var foodStore: FoodStore
    @EnvironmentObject var foodEntryStore: FoodEntryStore

    var body: some View {
        VStack(alignment: .leading) {
            Text("クイック追加")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(foodStore.foods) { food in
                        Button(action: {
                            // TODO: 長押しで量を変更できるようにする
                            foodEntryStore.addFoodEntry(food: food, quantity: 100)
                        }) {
                            Text(food.name ?? "無名")
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}
