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
    
    @State var viewState: ViewState = .kitchens
    
    var body: some View {
        KitchenView(kitchen: kitchens.kitchens[kitchenIndex.index], viewState: $viewState)
    }
}

struct KitchensViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        KitchensViewContainer()
    }
}
