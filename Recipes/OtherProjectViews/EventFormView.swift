//
// Created for UICalendarView_SwiftUI
// by Stewart Lynch on 2022-06-29
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//
import SwiftUI

@available(iOS 15.0, *)
struct EventFormView: View {
    @EnvironmentObject var kitchens: Kitchens
    @EnvironmentObject var kitchenIndex: KitchenIndex
    @StateObject var viewModel: EventFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    var body: some View {
//        NavigationStack {
            VStack {
                Form {
                    DatePicker(selection: $viewModel.date) {
                        Text("Date and Time")
                    }
                    TextField("Note", text: $viewModel.note)
                        .focused($focus, equals: true)
                    Picker("Event Type", selection: $viewModel.eventType) {
                        ForEach(Meal.MealType.allCases) {eventType in
                            Text(eventType.icon + " " + eventType.rawValue.capitalized)
                                .tag(eventType)
                        }
                    }
                    Section(footer:
                                HStack {
                        Spacer()
                        Button {
                            if viewModel.updating {
                                // update this event
                                let event = Meal(id: viewModel.id!,
                                                  mealType: viewModel.eventType,
                                                  date: viewModel.date,
                                                  note: viewModel.note)
//                                eventStore.update(event)
                                kitchens.kitchens[kitchenIndex.index].mealCalendar.update(event)
                            } else {
                                // create new event
                                let newEvent = Meal(mealType: viewModel.eventType,
                                                     date: viewModel.date,
                                                     note: viewModel.note)
                                kitchens.kitchens[kitchenIndex.index].mealCalendar.update(newEvent)
                            }
                            dismiss()
                        } label: {
                            Text(viewModel.updating ? "Update Event" : "Add Event")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.incomplete)
                        Spacer()
                    }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Update" : "New Event")
            .onAppear {
                focus = true
            }
        }
//    }
}

@available(iOS 15.0, *)
struct EventFormView_Previews: PreviewProvider {
    static var previews: some View {
        EventFormView(viewModel: EventFormViewModel())
            .environmentObject(Kitchens())
            .environmentObject(KitchenIndex())
    }
}
