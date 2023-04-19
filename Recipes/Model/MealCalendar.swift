//
// Created for UICalendarView_SwiftUI
// by Stewart Lynch on 2022-06-28
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
import Foundation
import FirebaseFirestoreSwift

//@MainActor
class MealCalendar: ObservableObject, Codable {
    @DocumentID var uid: String?
    @Published var meals = [Meal]()
    @Published var preview: Bool
    @Published var changedMeal: Meal?
    @Published var movedMeal: Meal?

    init(preview: Bool = false) {
        self.preview = preview
        fetchEvents()
    }

    func fetchEvents() {
        if preview {
            meals = Meal.sampleMeals
        } else {
            // load from your persistence store
        }
    }

    func delete(_ meal: Meal) {
        if let index = meals.firstIndex(where: {$0.id == meal.id}) {
            changedMeal = meals.remove(at: index)
        }
    }

    func add(_ meal: Meal) {
        meals.append(meal)
        changedMeal = meal
    }

    func update(_ meal: Meal) {
        if let index = meals.firstIndex(where: {$0.id == meal.id}) {
            movedMeal = meals[index]
            meals[index].date = meal.date
            meals[index].note = meal.note
            meals[index].mealType = meal.mealType
            changedMeal = meal
        }
    }
    
    
    
    
    enum CodingKeys: CodingKey {
        case meals
        case preview
        case changedMeal
        case movedMeal
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meals = try container.decode([Meal].self, forKey: .meals)
        preview = try container.decode(Bool.self, forKey: .preview)
        changedMeal = try container.decode(Meal.self, forKey: .changedMeal)
        movedMeal = try container.decode(Meal.self, forKey: .movedMeal)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(meals, forKey: .meals)
    }

}
