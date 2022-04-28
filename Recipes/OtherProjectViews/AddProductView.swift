//
//  AddProductView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/22/22.
//

import SwiftUI
import AVFoundation
import struct Kingfisher.KFImage

struct AddProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var presentView : Bool
    @EnvironmentObject var userInfo : UserInfo
    
    @ObservedObject var kitchen : Kitchen
    //@EnvironmentObject var kitchens : Kitchens
    //    @EnvironmentObject var kitchenIndex : KitchenIndex
    
    @State var product : Product = Product()
    
    @State var scannedCode = "0000"
    @State var isPresentingScanner = false
    @State var isPresentingProductSearch = false
    @State var searchedProductList = [ProductResult]()
    @State var query = ""
    @State var searchedIngredientList = [IngredientResult]()
    
//    var scannerSheet : some View {
//        CodeScannerView(
//            codeTypes: [AVMetadataObject.ObjectType.ean13],
//            completion: { result in
//                if case let .success(code) = result {
//                    self.scannedCode = code.string
//
//                    // convert EAN13 to UPC
//                    self.scannedCode.removeFirst()
//                    Api().getProductFromUPC(upc: scannedCode) { product in
//                        self.product = kitchen.createProduct(product: product)
//                        Api().classifyProduct(product: product) { classification in
//                            self.product.classification = classification
//                        }
//                    }
//                }
//            })
//    }
    
    var productSearchSheet : some View {
        
        VStack{
            Spacer()
            
            // For some reason the keyboard dismisses after typing the first character, can't seem to figure out why
            // Bug has gone away for me now, will keep this comment for reference
            Form{
                Section{
                    TextField(
                        "Search all grocery products",
                        text: $query)
                    
                    if(query.count > 0){
                        Button("Search"){
                            Api().searchProducts(query: query) { productList in
                                self.searchedProductList = productList
                            }
                        }
                    }
                    
                }
                Section{
                    List(searchedProductList){ productResult in
                        Button (action: {
                            Api().getProductFromId(id: productResult.id) { product in
                                self.product = kitchen.createProduct(product: product)
                                Api().classifyProduct(product: product) { classification in
                                    self.product.classification = classification
                                }
                                self.isPresentingProductSearch = false
                            }
                        }, label: {
                            HStack {
                                if(productResult.image != nil){
                                    KFImage(productResult.image!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text(productResult.title ?? "Error loading product")
                                Image(systemName: "arrow.right")
                            }
                        })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    
    
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
                        
                        
                        Button("Scan from barcode"){
                            self.isPresentingScanner = true
                        }
                        .sheet(isPresented: $isPresentingScanner){
//                            scannerSheet
                            productSearchSheet
                        }
                        .padding()
                        Button("Search for a product"){
                            self.isPresentingProductSearch = true
                        }
                        .sheet(isPresented: $isPresentingProductSearch){
                            productSearchSheet
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
                    if(product.title != "None") {
                        Button (action: {
                            kitchen.addProduct(product: product)
                            FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                                //
                            }
                            presentView = false
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Add product")
                        })
                    }
                    else{
                        Text("Add product")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
}


struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(presentView: .constant(true), kitchen: Kitchen())
            .environmentObject(UserInfo())
    }
}
