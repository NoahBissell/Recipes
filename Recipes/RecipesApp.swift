//  RecipesApp.swift
//  Recipes
//  Created on 1/4/22.
//  Created by Noah Bissell, but code not modified in any way from the default code for this class/struct.


import SwiftUI
import Firebase



class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct RecipesApp: App {
    @StateObject var kitchens = Kitchen()
    @StateObject var userInfo = UserInfo()
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(kitchen)
                .environmentObject(userInfo)
        }
    }
}


struct RecipesApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


