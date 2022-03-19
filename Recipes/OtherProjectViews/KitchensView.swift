//
//  KitchensView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 3/18/22.
//

import SwiftUI

struct KitchensView: View {
    
    @EnvironmentObject var kitchens : Kitchens
    var body: some View {
        NavigationView{
            VStack{
                ForEach(kitchens.kitchens.indices, id: \.self){ index in
                    NavigationLink(
                        destination: KitchenView().environmentObject(kitchens.kitchens[index]),
                        label: {
                            Text(kitchens.kitchens[index].name)
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
