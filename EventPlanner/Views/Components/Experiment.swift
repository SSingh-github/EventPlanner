import SwiftUI
import _PhotosUI_SwiftUI

struct AsyncImageView: View {
    
    let imageUrl: String
    let frameHeight: Double
    
    var body: some View {
        // Show the image using the URL
        VStack {
            //event card and event details
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    // Placeholder view while the image is being loaded
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                            .frame(width: 200, height: 150)
                            .scaleEffect(3)
                        
                        Spacer()
                    }
                case .success(let image):
                    // Display the loaded image
                    image
                        .resizable()
                        .frame(height: 150)
                        .scaledToFit()
                        .cornerRadius(20)
                case .failure(_):
                    // Show an error placeholder if the image fails to load
                    Rectangle()
                        .frame(height: 150)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                @unknown default:
                    // Handle any future cases if needed
                    EmptyView()
                }
            }
            // event details
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Colors.blueThemeColor))
                            .frame(width: 200, height: 150)
                            .scaleEffect(3)
                        
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                case .failure(_):
                    Rectangle()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            //profile and edit profile view
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                case .failure(_):
                    Image(systemName: Constants.Images.personFill)
                        .font(.system(size: 100))
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }                            }
            
        }
    }
}

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
