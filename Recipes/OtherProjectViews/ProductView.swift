//
//  ProductView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/23/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var product: Product
    @EnvironmentObject var userInfo : UserInfo
    @ObservedObject var kitchen : Kitchen
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.background)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    if(product.image != nil){
                        KFImage(product.image)
                            .padding()
                    }
                    VStack(spacing: 20){
                        if(product.title == "None") {
                            Text("New product")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        else {
                            Text("Product: \(product.title)")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        if let unwrappedClassification = product.classification{
                            //                Text("Title: \(unwrappedClassification.cleanTitle)")
                            Text("\(unwrappedClassification.category.capitalized)")
                        }
                        
                        
                        Stepper("Amount: \(product.quantity)")
                        {
                            if(product.storedQuantity != nil){
                                product.storedQuantity! += 1
                            }
                        } onDecrement: {
                            if(product.quantity >= 2){
                                if(product.storedQuantity != nil){
                                    product.storedQuantity! -= 1
                                }
                            }
                        }
                        .padding()
                        
                    
                        
                    }
                    .frame(width: geo.size.width * 0.9)
                    .background(Color.foreground)
                    .cornerRadius(20)
                    .shadow(radius:20)
                    .padding()
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

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: .constant(Product()), kitchen: Kitchen())
            .environmentObject(UserInfo())
    }
}
