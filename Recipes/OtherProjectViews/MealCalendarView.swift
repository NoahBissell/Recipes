//
//  MealCalendarView.swift
//  Recipes
//
//  Created by Noah Bissell on 4/17/23.
//

import SwiftUI

struct MealCalendarView: View {
    @EnvironmentObject var kitchens: Kitchens
    @EnvironmentObject var kitchenIndex: KitchenIndex
    var body: some View {
        if #available(iOS 16.0, *) {
            CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture), kitchens: kitchens)
        }
        else {
            Text("Your device does not support the calendar feature. Upgrade to iOS 16 or newer.")
        }
    }
}

struct MealCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MealCalendarView()
    }
}
