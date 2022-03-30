//
//  KitchensView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 3/18/22.
//

//**************************//
// NOT BEING USED RIGHT NOW //
//**************************//

import SwiftUI

struct KitchensView: View {
    
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    
    //@StateObject var kitchen : Kitchen = Kitchen()
    
    var body: some View {
        NavigationView{
            VStack{
                ForEach(kitchens.kitchens.indices, id: \.self){ index in
                    NavigationLink(
                        destination: KitchenView().id(UUID())
                        , label: {
                            Text(kitchens.kitchens[index].name)
                        })
                        .simultaneousGesture(TapGesture().onEnded{
                            kitchenIndex.index = index
                        })
                    
                }
            }
        }
    }
}

struct KitchensView_Previews: PreviewProvider {
    static var previews: some View {
        KitchensView().environmentObject(Kitchens())
    }
}
