import SwiftUI

struct ContentView: View {
    @StateObject private var foodStore = FoodStore()
    
    var body: some View {
        VStack(spacing: 0) {
            // 上半分: 合計表示とプログレスバー
            VStack(spacing: 20) {
                // 合計表示
                Text("今日の合計")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                HStack(spacing: 15) {
                    VStack {
                        Text("P")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(foodStore.totalP))g")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        Text("F")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(foodStore.totalF))g")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        Text("C")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(foodStore.totalC))g")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        Text("Kcal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(foodStore.totalK))")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                // プログレスバー
                VStack(spacing: 8) {
                    ProgressRow(label: "P", progress: foodStore.progressP, color: .blue)
                    ProgressRow(label: "F", progress: foodStore.progressF, color: .orange)
                    ProgressRow(label: "C", progress: foodStore.progressC, color: .green)
                    ProgressRow(label: "K", progress: foodStore.progressK, color: .red)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            
            Divider()
            
            // 下半分: クイック食材ボタンと履歴
            VStack(spacing: 20) {
                // クイック食材ボタン
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(foodStore.recentFoods) { food in
                            Button(action: {
                                foodStore.addFood(food)
                            }) {
                                VStack(spacing: 5) {
                                    Text(food.name)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    Text("P\(Int(food.servingP))")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 10)
                
                // 今日の履歴
                if !foodStore.todayEntries.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("今日の記録")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        List(foodStore.todayEntries.reversed()) { entry in
                            HStack {
                                Text(entry.food.name)
                                    .fontWeight(.medium)
                                Spacer()
                                Text("P\(Int(entry.totalP)) F\(Int(entry.totalF)) C\(Int(entry.totalC)) K\(Int(entry.totalK))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 2)
                        }
                        .listStyle(PlainListStyle())
                    }
                } else {
                    Text("食材をタップして記録を開始")
                        .foregroundColor(.secondary)
                        .padding(.top, 40)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ProgressRow: View {
    let label: String
    let progress: Double
    let color: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .frame(width: 20, alignment: .leading)
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
                .frame(height: 8)
            
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(width: 35, alignment: .trailing)
        }
    }
}

#Preview {
    ContentView()
}