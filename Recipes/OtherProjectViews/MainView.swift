//
//  MainView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 3/2/22.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @EnvironmentObject var userInfo : UserInfo
    
    

    var body : some View {


        TabView{
            KitchensViewContainer()
                .tabItem(){
                    if #available(iOS 14.5, *) {
                        Label("Kitchen", systemImage: "house")
                            .labelStyle(TitleAndIconLabelStyle())
                    } else {
                        Text("Kitchen")
                    }
                }

            CookbookView()
                .tabItem(){
                    if #available(iOS 14.5, *) {
                        Label("Cookbook", systemImage: "text.book.closed")
                            .labelStyle(TitleAndIconLabelStyle())
                    } else {
                        Text("Cookbook")
                    }
                }
            MealCalendarView()
                .tabItem() {
                    if #available(iOS 14.5, *) {
                        Label("Meal Calendar", systemImage: "calendar")
                            .labelStyle(TitleAndIconLabelStyle())
                    } else {
                        Text("Calendar")
                    }
                }
            SettingsView()
                .tabItem(){
                    if #available(iOS 14.5, *) {
                        Label("Settings", systemImage: "gear")
                            .labelStyle(TitleAndIconLabelStyle())
                    } else {
                        Text("Settings")
                    }
                }
        }
        .onAppear(perform: {
            if(userInfo.loggedIn) {
//            userInfo.initialize { completed in
                kitchenIndex.index = 0
                kitchens.kitchens.removeAll()
                print("by\(userInfo.kitchenIds.count)")
                kitchens.initialize(userInfo: userInfo)
//            }
            }
//            FirebaseFunctions.addUser(userInfo: userInfo)
        })



    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Kitchen())
    }
}

