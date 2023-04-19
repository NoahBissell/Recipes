//
//  MealCalendarView.swift
//  Recipes
//
//  Created by Noah Bissell on 4/17/23.
//

//import SwiftUI
//
//struct MealCalendarView: View {
//    @EnvironmentObject var kitchens: Kitchens
//    @EnvironmentObject var kitchenIndex: KitchenIndex
//    @State var isEventFormActive: Bool = false
//    var body: some View {
//        NavigationView {
//            if #available(iOS 16.0, *) {
//                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture), kitchens: kitchens)
//            }
//            else {
//                Text("Your device does not support the calendar feature. Upgrade to iOS 16 or newer.")
//            }
//        }
//        .sheet(isPresented: $isEventFormActive, content: {
//            EventFormView(, viewModel: <#EventFormViewModel#>)
//                .environmentObject(kitchens)
//                .environmentObject(kitchenIndex)
//        })
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    isEventFormActive = true
//                }, label: {
//                    Image(systemName: "plus")
//                })
//
//            }
//
//        }
//    }
//}
//struct MealCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealCalendarView()
//    }
//}


//
// Created for UICalendarView_SwiftUI
// by Stewart Lynch on 2022-06-28
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
import SwiftUI

struct MealCalendarView: View {
    @EnvironmentObject var kitchens: Kitchens
    @EnvironmentObject var kitchenIndex: KitchenIndex
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    @State private var formType: EventFormType?
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationView {
                ScrollView {
                    CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture),
                                 kitchens: kitchens,
                                 kitchenIndex: kitchenIndex,
                                 dateSelected: $dateSelected,
                                 displayEvents: $displayEvents)
                    Image("launchScreen")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            formType = .new
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.medium)
                        }
                    }
                }
                .sheet(item: $formType) { $0 }
//                .sheet(isPresented: $displayEvents) {
//                    DaysEventsListView(dateSelected: $dateSelected)
//                        .presentationDetents([.medium, .large])
//                }
                
                .navigationTitle("Calendar View")
            }
        }
    }
}

struct MealCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MealCalendarView()
            .environmentObject(Kitchens())
            .environmentObject(KitchenIndex())
    }
}
