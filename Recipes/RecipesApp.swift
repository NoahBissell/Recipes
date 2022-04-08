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
    @StateObject var kitchens = Kitchens(kitchens: [Kitchen(), Kitchen()])
    @StateObject var userInfo = UserInfo()
    @StateObject var cookbook = Cookbook()
    @StateObject var kitchenIndex : KitchenIndex = KitchenIndex(index: 0)
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(kitchens)
                .environmentObject(userInfo)
                .environmentObject(cookbook)
                .environmentObject(kitchenIndex)
        }
    }
}


struct RecipesApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


