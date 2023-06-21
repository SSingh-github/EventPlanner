
import SwiftUI

struct DateTimePickerView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        VStack {
            Text(Constants.Labels.dateAndTime)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 40)
            Picker("", selection: $viewModel.selected) {
                ForEach(Constants.Labels.segments, id:\.self) { segment in
                    Text(segment)
                        .tag(segment)
                }
            }
            .pickerStyle(.segmented)
            .background(Constants.Colors.blueThemeColor)
            .cornerRadius(8)
            .padding()
            
            if viewModel.selected == Constants.Labels.segments[0] {
                DatePicker("", selection: viewModel.actionType == .createEvent ? $viewModel.newEvent.startDate : $viewModel.newEventForEdit.startDate, in: (viewModel.actionType == .createEvent ? Date() : viewModel.newEventForEdit.startDate)..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                
                DatePicker(Constants.Labels.selectStartTime, selection: viewModel.actionType == .createEvent ? $viewModel.newEvent.startDate : $viewModel.newEventForEdit.startDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
            }
            else {
                if viewModel.actionType == .createEvent {
                    DatePicker("", selection: $viewModel.newEvent.endDate, in: viewModel.newEvent.startDate..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                    
                    DatePicker(Constants.Labels.selectEndTime, selection: $viewModel.newEvent.endDate,in: (viewModel.newEvent.startDate + (3600))..., displayedComponents: .hourAndMinute)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                }
                else {
                    DatePicker("", selection: $viewModel.newEventForEdit.endDate, in: viewModel.newEventForEdit.startDate..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                    
                    DatePicker(Constants.Labels.selectEndTime, selection: $viewModel.newEventForEdit.endDate,in: (viewModel.newEventForEdit.startDate + (3600))..., displayedComponents: .hourAndMinute)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                }
            }
//            if viewModel.newEvent.startDate == viewModel.newEvent.endDate {
//                Text(Constants.Labels.durationMessage)
//                    .font(.caption)
//            }
        }
    }
}
struct DateTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePickerView(viewModel: MainTabViewModel())
    }
}
