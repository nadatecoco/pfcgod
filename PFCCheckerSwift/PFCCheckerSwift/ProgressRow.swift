import SwiftUI

struct ProgressRow: View {
    // 目標値（仮） - 将来的にはユーザーが設定できるようにすると良い
    private let targetP: Double = 120 // g
    private let targetF: Double = 60  // g
    private let targetC: Double = 250 // g
    private let targetK: Double = 2000 // kcal

    var totalP: Double
    var totalF: Double
    var totalC: Double
    var totalK: Double

    var body: some View {
        VStack(spacing: 8) {
            ProgressBar(value: totalP, target: targetP, label: "P", color: .blue)
            ProgressBar(value: totalF, target: targetF, label: "F", color: .red)
            ProgressBar(value: totalC, target: targetC, label: "C", color: .orange)
            ProgressBar(value: totalK, target: targetK, label: "K", color: .green)
        }
        .padding(.horizontal)
    }
}

struct ProgressBar: View {
    var value: Double
    var target: Double
    var label: String
    var color: Color

    private var progress: CGFloat {
        if target == 0 { return 0 }
        return min(CGFloat(value / target), 1.0) // 100%を上限
    }

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .frame(width: 20, alignment: .leading)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(color.opacity(0.2))
                        .frame(height: 8)
                    Rectangle()
                        .foregroundColor(color)
                        .frame(width: geometry.size.width * progress, height: 8)
                }
                .cornerRadius(4)
            }
            .frame(height: 8)
        }
    }
}