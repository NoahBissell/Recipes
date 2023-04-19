//
// Created for UICalendarView_SwiftUI
// by Stewart Lynch on 2022-06-29
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
import Foundation

class EventFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var note = ""
    @Published var eventType: Meal.MealType = .breakfast

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ event: Meal) {
        date = event.date
        note = event.note
        eventType = event.mealType
        id = event.id
    }

    var incomplete: Bool {
        note.isEmpty
    }
}
