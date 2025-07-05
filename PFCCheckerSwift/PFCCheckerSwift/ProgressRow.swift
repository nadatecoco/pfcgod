import SwiftUI

struct ProgressRow: View {
    let totalP: Double
    let totalF: Double
    let totalC: Double
    let totalK: Double
    
    var body: some View {
        VStack(spacing: 8) {
            // 上段：合計ラベル
            Text("P \(Int(totalP))g / F \(Int(totalF))g / C \(Int(totalC))g / K \(Int(totalK))kcal")
                .font(.headline)
                .padding(.horizontal)
            
            // 下段：4分割プログレスバー
            HStack(spacing: 2) {
                // P - 青
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                
                // F - 赤
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                
                // C - オレンジ
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                
                // K - 緑
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProgressRow(totalP: 25, totalF: 8, totalC: 60, totalK: 450)
        .padding()
}