//
//  ContentView.swift
//  PFCCheckerSwift
//
//  Created by なたてここ on 2025/07/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("PFC Counter")
                .font(.largeTitle)
                .padding()
            
            // ProgressRow を使用（ショートカット！）
            ProgressRow(totalP: 25, totalF: 8, totalC: 60, totalK: 450)
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
