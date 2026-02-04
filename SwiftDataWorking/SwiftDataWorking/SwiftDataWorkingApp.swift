//
//  SwiftDataWorkingApp.swift
//  SwiftDataWorking
//
//  Created by Koray Urun on 4.02.2026.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataWorkingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Tüm uygulama genelinde bu modeli kullanacağımızı belirtiyoruz
        .modelContainer(for: TodoItem.self)
    }
}
