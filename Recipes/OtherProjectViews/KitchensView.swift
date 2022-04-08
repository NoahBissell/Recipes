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
    
    @State private var selectedItemId : UUID?
    
    @Binding var viewState : ViewState
    
    //@StateObject var kitchen : Kitchen = Kitchen()
    
    var body: some View {
        NavigationView{
            VStack{
                ForEach(kitchens.kitchens.indices, id: \.self){ index in
//                    NavigationLink(
//                        destination: KitchenView(kitchen: kitchens.kitchens[0]).id(UUID())
//                        , label: {
//                            Text(kitchens.kitchens[0].name)
//                        })
//                        .simultaneousGesture(TapGesture().onEnded{
//                            kitchenIndex.index = 0
//                        })
//                    NavigationLink(
//                        destination: KitchenView(kitchen: kitchens.kitchens[index]),
//                        tag: kitchens.kitchens[index].ownerId,
//                        selection: $selectedItemId,
//                        label: {Text("Navigate")})
                    Button(action: {
                        self.kitchenIndex.index = index
                        self.viewState = .kitchen
                    }, label: {
                        Text(kitchens.kitchens[kitchenIndex.index].name)
                    })
                    
                }
            }
        }
    }
}

struct KitchensView_Previews: PreviewProvider {
    static var previews: some View {
        KitchensView(viewState: .constant(ViewState.kitchens)).environmentObject(Kitchens())
    }
}
