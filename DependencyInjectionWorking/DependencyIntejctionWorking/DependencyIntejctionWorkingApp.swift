//
//  DependencyIntejctionWorkingApp.swift
//  DependencyIntejctionWorking
//
//  Created by Koray Urun on 5.02.2026.
//

import SwiftUI
import SwiftData

@main
struct DependencyIntejctionWorkingApp: App {

    var body: some Scene {
        WindowGroup {
            MainDashBoardView(container: AppContainer())
        }
    }
}
