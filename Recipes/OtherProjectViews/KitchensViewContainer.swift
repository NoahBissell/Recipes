//
//  KitchensViewContainer.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 4/6/22.
//

import SwiftUI


enum ViewState{
    case kitchens
    case kitchen
}

struct KitchensViewContainer: View {
    
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @EnvironmentObject var userInfo : UserInfo
    
    @State var viewState: ViewState = .kitchens
    
    var body: some View {
        if(kitchens.kitchens.count != 0) {
            KitchenView(kitchen: kitchens.kitchens[kitchenIndex.index], viewState: $viewState)
        }
        else {
            NoKitchensView()
        }
    }
}

struct KitchensViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        KitchensViewContainer()
    }
}
