//
//  CalendarView.swift
//  Recipes
//
//  Created by Noah Bissell on 4/16/23.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct CalendarView: UIViewRepresentable {
   
    let interval: DateInterval
    @ObservedObject var kitchens: Kitchens
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, kitchens: _kitchens)
    }
    
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    
    
    class Coordinator: NSObject, UICalendarViewDelegate {
        var parent: CalendarView
        @ObservedObject var kitchens: Kitchens
        init(parent: CalendarView, kitchens: ObservedObject<Kitchens>) {
            self.parent = parent
            self._kitchens = kitchens
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            var scheduledMeals = [Meal]()
            for kitchen in kitchens.kitchens {
                for meals in kitchen.mealCalendar.meals {
                    scheduledMeals.append(meals)
                }
            }
            
            let foundMeals = scheduledMeals.filter { $0.date.startOfDay == dateComponents.date?.startOfDay }
            if foundMeals.isEmpty {
                return nil
            }
            if foundMeals.count > 1 {
                return .image(UIImage(systemName: "doc.on.doc.fill"), color: .red, size: .large)
            }
            let singleMeal = foundMeals.first!
            return .customView {
                let icon = UILabel()
                icon.text = singleMeal.note
                return icon
            }
        }
        
    }
    
    
}
