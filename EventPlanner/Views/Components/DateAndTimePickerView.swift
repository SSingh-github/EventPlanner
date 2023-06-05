
import SwiftUI

struct DateTimePickerView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var formattedStartDate = ""
    @State private var formattedEndDate = ""
    
    var body: some View {
        ScrollView {
            VStack {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("Start Time", selection: $startDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Button(action: {
                    // Format and store the start date and end date in separate strings
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    formattedStartDate = dateFormatter.string(from: startDate)
                    formattedEndDate = dateFormatter.string(from: endDate)
                    
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm"
                    let formattedStartTime = timeFormatter.string(from: startDate)
                    let formattedEndTime = timeFormatter.string(from: endDate)
                    
                    print("Start Date:", formattedStartDate)
                    print("Start Time:", formattedStartTime)
                    print("End Date:", formattedEndDate)
                    print("End Time:", formattedEndTime)
                }) {
                    Text("Confirm")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Text("Formatted Start Date: \(formattedStartDate)")
                Text("Formatted End Date: \(formattedEndDate)")
            }
        }
    }
}
struct DateTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePickerView()
    }
}
