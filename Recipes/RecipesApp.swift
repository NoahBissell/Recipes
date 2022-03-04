//  RecipesApp.swift
//  Recipes
//  Created on 1/4/22.
//  Created by Noah Bissell, but code not modified in any way from the default code for this class/struct.

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject var kitchen = Kitchen()
    @StateObject var userInfo = UserInfo()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(kitchen).environmentObject(userInfo)
        }
    }
}
