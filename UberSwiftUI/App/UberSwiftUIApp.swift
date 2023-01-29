//
//  UberSwiftUIApp.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/26.
//

import SwiftUI

@main
struct UberSwiftUIApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
