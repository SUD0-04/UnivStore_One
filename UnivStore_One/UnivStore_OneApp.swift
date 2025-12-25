//
//  UnivStore_OneApp.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI

@main
struct UnivStore_OneApp: App {
    @AppStorage("hasSeenStart") private var hasSeenStart: Bool = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenStart {
                    ContentView()
                } else {
                    StartView()
                }
            }
            .animation(.default, value: hasSeenStart)
        }
    }
}
