//
//  CalendarHelper.swift
//  EventPlanner
//
//  Created by Chicmic on 19/06/23.
//

import Foundation
import SwiftUI
struct CalendarStruct: UIViewRepresentable {
   
    //MARK: PROPERTIES
    let interval: DateInterval
    
    @ObservedObject var viewModel: MainTabViewModel
    @Binding var dateSelected: DateComponents?
    @Binding var displayEvents: Bool
    
    //MARK: METHODS
    
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
    
    //MARK: COORDINATOR CLASS
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        //MARK: PROPERTIES
        @ObservedObject var viewModel: MainTabViewModel
        var parent: CalendarStruct
        
        //MARK: INITIALIZER
        init(viewModel: ObservedObject<MainTabViewModel>, parent: CalendarStruct) {
            self._viewModel = viewModel
            self.parent = parent
        }
        
        //MARK: METHODS
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
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
                return .image(UIImage(systemName: Constants.Images.docFill), color: Constants.Colors.polylineColor, size: .large)
            }
            
            return .customView {
                self.createBlueCircleView(withTitle: Constants.Labels.event)
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
