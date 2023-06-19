import SwiftUI
import _PhotosUI_SwiftUI


struct PickerView : View {

      @State var gender : String? = nil
      @State var arrGenders = ["Male","Female","Unknown"]
      @State var selectionIndex = 0
    @State var imagePicker = ImagePicker()

      var body : some View {
          ZStack {
              
              if let image = imagePicker.image {
                  Image(uiImage:image)
                       .resizable()
                       .frame(height: 250)
                       .scaledToFit()
                       .cornerRadius(20)
                  
                  PhotosPicker(selection: $imagePicker.imageSelection, matching: .images) {
                      Image(systemName: "photo.on.rectangle")
                          .font(.largeTitle)
                          .padding(15)
                          .foregroundColor(.black)
                          .background(.white)
                          .clipShape(Circle())
                  }
                  
              }
              else {
                  Rectangle()
                      .frame(height: 250)
                      .cornerRadius(20)
                      .foregroundColor(.secondary)
                  PhotosPicker(selection: $imagePicker.imageSelection, matching: .images) {
                      VStack {
                          Spacer()
                          HStack {
                              Spacer()
                              Image(systemName: "photo.on.rectangle")
                                  .font(.subheadline)
                                  .padding(15)
                                  .foregroundColor(.black)
                                  .background(.white)
                                  .clipShape(Circle())
                          }
                          .padding()
                      }
                      .frame(height: 250)

                  }
                  
              }
              
              
          }
     }
 }

struct CalendarEventsList_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
