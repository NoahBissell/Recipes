//
//  Meal.swift
//  Recipes
//
//  Created by Noah Bissell on 4/17/23.
//

import Foundation
import FirebaseFirestoreSwift

class Meal: Codable, Identifiable {
    @DocumentID var uid : String?
    
    enum MealType: String, Identifiable, CaseIterable, Codable {
        case breakfast, lunch, dinner
        var id: String {
            self.rawValue
        }

        var icon: String {
            switch self {
            case .breakfast:
                return "🥞"
            case .lunch:
                return "🥪"
            case .dinner:
                return "🍽️"
            }
        }
    }
    var mealType: MealType
    var recipe: Recipe
    var date: Date
    var note: String
    var id: Int?
    
    var dateComponents: DateComponents {
            var dateComponents = Calendar.current.dateComponents(
                [.month,
                 .day,
                 .year,
                 .hour,
                 .minute],
                from: date)
            dateComponents.timeZone = TimeZone.current
            dateComponents.calendar = Calendar(identifier: .gregorian)
            return dateComponents
        }

    init(id: String = UUID().uuidString, mealType: MealType = .breakfast, recipe: Recipe = Recipe(), date: Date, note: String) {
        self.mealType = mealType
        self.date = date
        self.note = note
        self.recipe = recipe
    }
    
    enum CodingKeys: CodingKey {
        case mealType
        case date
        case note
        case recipe
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealType = try container.decode(MealType.self, forKey: .mealType)
        date = try container.decode(Date.self, forKey: .date)
        note = try container.decode(String.self, forKey: .note)
        recipe = try container.decode(Recipe.self, forKey: .recipe)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mealType, forKey: .mealType)
        try container.encode(date, forKey: .date)
        try container.encode(note, forKey: .note)
        try container.encode(recipe, forKey: .recipe)
    }

    // Data to be used in the preview
    static var sampleMeals: [Meal] {
        return [
            Meal(mealType: .breakfast, date: Date(), note: "Sample")
        ]
    }
}
