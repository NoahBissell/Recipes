//
//  IngredientView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/28/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct IngredientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userInfo : UserInfo
    @ObservedObject var kitchen : Kitchen

    @Binding var ingredient : Ingredient
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.background)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    if(ingredient.image != nil){
                        KFImage(ingredient.getImageURL())
                            .padding()
                    }
                    
                    VStack(spacing: 20){
                        if(ingredient.name == "None") {
                            Text("New ingredient")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        else {
                            Text("Ingredient: \(ingredient.name)")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        
                        
                        
                        Stepper(value: $ingredient.amount, in: 0.1...100.0, step: 0.1) {
                            Text("Amount: \(ingredient.amount, specifier: "%.1f")")
                        }
                        .padding()
                        
                        HStack{
                            Text("Units: ")
                            Picker("Units", selection: $ingredient.unit) {
                                ForEach(ingredient.possibleUnits, id: \.self){ unit in
                                    Text(unit)
                                }
                            }
                            .id(ingredient.possibleUnits)
                        }
                        .padding()
                    }
                    .frame(width: geo.size.width * 0.9)
                    .background(Color.foreground)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
            }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button (action: {
                    FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                        //
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                })
            }
        }
    }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(kitchen: Kitchen(), ingredient: .constant(Ingredient()))
    }
}
