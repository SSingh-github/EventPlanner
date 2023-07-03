
import SwiftUI

struct DateTimePickerView: View {
    
    @ObservedObject var viewModel: MainTabViewModel
    @State var maxDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    @State var today = Date()
    
    var body: some View {
        VStack {
            
            //MARK: PICKER TO PICK START AND ENDING DATE
            
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
                
                //MARK: START DATE

                DatePicker("", selection: viewModel.actionType == .createEvent ? $viewModel.newEvent.startDate : $viewModel.newEventForEdit.startDate, in:  Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .accentColor(Constants.Colors.blueThemeColor)
                    .background(.secondary.opacity(0.2))
                    .cornerRadius(20)
                
                
                //MARK: START TIME
                
                DatePickerTextFieldView(label: Constants.Labels.selectStartTime, placeholder: Constants.Labels.Placeholders.startTime, date: viewModel.actionType == .createEvent ? $viewModel.newEvent.startTime : $viewModel.newEventForEdit.startTime, minimumDate: $today, maximumDate: $maxDate, pickerType: .time)
                    .padding(.horizontal)
            }
            else {
                if viewModel.actionType == .createEvent {
                    
                    //MARK: END DATE
                    
                    DatePicker("", selection: $viewModel.newEvent.endDate, in: viewModel.newEvent.startDate...Calendar.current.date(byAdding: .year, value: 1, to: Date())!, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                        .background(.secondary.opacity(0.2))
                        .cornerRadius(20)
                    
                    //MARK: ENDING TIME
                    DatePickerTextFieldView(label: Constants.Labels.selectEndTime, placeholder: Constants.Labels.Placeholders.endTime, date: $viewModel.newEvent.endTime, minimumDate: $viewModel.newEvent.startDate, maximumDate: $maxDate, pickerType: .time)
                        .padding(.horizontal)
                }
                else {
                    //MARK: ENDING DATE FOR UPDATE EVENT
                    
                    DatePicker("", selection: $viewModel.newEventForEdit.endDate, in: viewModel.newEventForEdit.startDate...Calendar.current.date(byAdding: .year, value: 1, to: Date())!, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .accentColor(Constants.Colors.blueThemeColor)
                        .background(.secondary.opacity(0.2))
                        .cornerRadius(20)
                    
                    //MARK: ENDING TIME FOR UPDATE EVENT
                    
                    DatePickerTextFieldView(label: Constants.Labels.selectEndTime, placeholder: Constants.Labels.Placeholders.endTime, date: $viewModel.newEventForEdit.endTime, minimumDate: $viewModel.newEventForEdit.startDate, maximumDate: $maxDate, pickerType: .time)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct DateTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePickerView(viewModel: MainTabViewModel())
    }
}
