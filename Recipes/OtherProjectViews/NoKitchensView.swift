//
//  NoKitchensView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 4/23/22.
//

import SwiftUI

struct NoKitchensView: View {
    
    
    var body: some View {
        NavigationView {
        
            VStack {
                Text("You aren't currently part of any kitchens.")
                NavigationLink("Make your own kitchen", destination: AddKitchenView(presentView: .constant(true)))
                
            }
        }
    }
}

struct NoKitchensView_Previews: PreviewProvider {
    static var previews: some View {
        NoKitchensView()
    }
}
