//
//  ScheduleMealView.swift
//  Recipes
//
//  Created by Noah Bissell on 4/17/23.
//

import SwiftUI

struct ScheduleMealView : View {
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    var recipe : Recipe
    @State var isPresentingAlert : Bool = false
    func cancel () -> (){}
    
    
    var body : some View {
        Text("Not implemented")
    }
}

struct ScheduleMealView_Previews : PreviewProvider {
    static var previews: some View {
        ScheduleMealView(recipe: Recipe())
    }
}
