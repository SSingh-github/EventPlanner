import SwiftUI


struct PickerView : View {
    @State private var date: Date?
      var body : some View {
          DatePickerTextField(placeholder: "select Date", date: $date, pickerType: .date)
     }
 }

struct CalendarEventsList_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
