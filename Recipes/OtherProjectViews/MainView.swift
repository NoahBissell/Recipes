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



    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Kitchen())
    }
}

