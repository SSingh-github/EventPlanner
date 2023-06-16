//
//  CalendarView.swift
//  EventPlanner
//
//  Created by Chicmic on 13/06/23.
//

import SwiftUI

struct CalendarStruct: UIViewRepresentable {
   
    let interval: DateInterval
    
    @ObservedObject var viewModel: MainTabViewModel
    @Binding var dateSelected: DateComponents?
    @Binding var displayEvents: Bool
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    

    func makeUIView(context: Context) -> some UIView {
        let view = UICalendarView()
        view.availableDateRange = interval
        view.delegate = context.coordinator
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: _viewModel, parent: self)
    }
    
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        
        @ObservedObject var viewModel: MainTabViewModel
        var parent: CalendarStruct
        
        init(viewModel: ObservedObject<MainTabViewModel>, parent: CalendarStruct) {
            self._viewModel = viewModel
            self.parent = parent
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
//            let foundEvents = viewModel.events.filter { $0.date.startOfDay == dateComponents.date?.startOfDay }
//
            var foundEvents: [Event] = []
            
            for event in viewModel.joinedEvents {
                let startDate = Formatter.shared.createDateFromString(date: event.start_date)
                if startDate?.startOfDay == dateComponents.date?.startOfDay  {
                    foundEvents.append(event)
                }
            }
            
            if foundEvents.isEmpty {
                return nil
            }
            
            if foundEvents.count > 1 {
                return .image(UIImage(systemName: "doc.on.doc.fill"), color: .red, size: .large)
            }
            
            return .customView {
                self.createBlueCircleView(withTitle: "Event")
            }
        }
        

        func createBlueCircleView(withTitle title: String) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            view.backgroundColor = Constants.Colors.polylineColor
            view.layer.cornerRadius = 0
            view.layer.masksToBounds = true
            view.layer.borderColor  = .init(red: 206/255, green: 0, blue: 0, alpha: 1)
           
        
          

            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            label.text = title
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            return view
        }

        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else { return }
            var foundEvents: [Event] = []
            
            for event in viewModel.joinedEvents {
                let startDate = Formatter.shared.createDateFromString(date: event.start_date)
                if startDate?.startOfDay == dateComponents.date?.startOfDay  {
                    foundEvents.append(event)
                }
            }
            
            if !foundEvents.isEmpty {
                parent.displayEvents.toggle()
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool{
            return true
        }
    }
}

struct CalendarView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    
    var body: some View {
        ScrollView{
            //give the starting and ending dates on the calendar.
            CalendarStruct(interval: DateInterval(start: .distantPast, end: .distantFuture), viewModel: viewModel, dateSelected: $dateSelected, displayEvents: $displayEvents)
                .accentColor(Constants.Colors.blueThemeColor)
        }
        .sheet(isPresented: $displayEvents) {
            CalendarEventsList(viewModel: viewModel, dateSelected: $dateSelected)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: MainTabViewModel())
    }
}
