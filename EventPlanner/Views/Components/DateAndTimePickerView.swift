
import SwiftUI

struct DateTimePickerView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                DatePicker("", selection: $viewModel.startDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("", selection: $viewModel.startDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("", selection: $viewModel.endDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("", selection: $viewModel.endDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Button(action: {
                    // Format and store the start date and end date in separate strings
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = Constants.StringFormats.dateFormat
                    viewModel.formattedStartDate = dateFormatter.string(from: viewModel.startDate)
                    viewModel.formattedEndDate = dateFormatter.string(from: viewModel.endDate)
                    
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = Constants.StringFormats.timeFormat
                    viewModel.formattedStartTime = timeFormatter.string(from: viewModel.startDate)
                    viewModel.formattedEndTime = timeFormatter.string(from: viewModel.endDate)
                    
                    print("Start Date:", viewModel.formattedStartDate)
                    print("Start Time:", viewModel.formattedStartTime)
                    print("End Date:", viewModel.formattedEndDate)
                    print("End Time:", viewModel.formattedEndTime)
                }) {
                    Text("Confirm")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Text("Formatted Start Date: \(viewModel.formattedStartDate)")
                Text("Formatted End Date: \(viewModel.formattedEndDate)")
            }
        }
    }
}
struct DateTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePickerView(viewModel: AddEventViewModel())
    }
}
