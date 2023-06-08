
import SwiftUI

struct DateTimePickerView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    
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
                DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                
                DatePicker(Constants.Labels.selectStartTime, selection: $viewModel.startDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
            }
            else {
                DatePicker("", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                
                DatePicker(Constants.Labels.selectEndTime, selection: $viewModel.endDate,in: (viewModel.startDate + (3600))..., displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
               
            }
            if viewModel.startDate == viewModel.endDate {
                Text(Constants.Labels.durationMessage)
                    .font(.caption)
            }
        }
    }
}
struct DateTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePickerView(viewModel: AddEventViewModel())
    }
}
