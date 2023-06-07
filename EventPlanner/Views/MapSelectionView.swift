//
//  MapSelectionView.swift
//  EventPlanner
//
//  Created by Chicmic on 06/06/23.
//

import SwiftUI
import MapKit

struct MapViewSelection: View {
   
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var mainViewModel: MainTabViewModel
    @ObservedObject var viewModel: AddEventViewModel
    @Environment(\.colorScheme) var colorScheme
   
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            if let place = locationManager.pickedMark {
                VStack(spacing: 15) {
                    Text(Constants.Labels.currentLocation)
                        .font(.title2)
                        .bold()
                    
                    HStack(spacing: 15) {
                        Image(systemName: Constants.Images.mappin)
                            .font(.title2)
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title3)
                                .bold()
                            
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        viewModel.pickedLocation = locationManager.pickedLocation
                        viewModel.pickedMark = locationManager.pickedMark
                        viewModel.printData()
                        viewModel.postNewEvent(viewModel: mainViewModel, appState: appState)
                    } label: {
                        Text(Constants.Labels.confirmLocation)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle (cornerRadius: 10, style: .continuous)
                                    .fill(Constants.Colors.blueThemeColor)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: Constants.Images.rightArrow)
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundColor(.white)
                            .ignoresSafeArea()
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text(""), message: Text(viewModel.alertMessage),
                            dismissButton: .default(Text(Constants.Labels.ok)
                                .foregroundColor(Constants.Colors.blueThemeColor)))
                    }
                }
                .padding()
                .background(colorScheme == .dark ? .black : .white)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            if viewModel.postingNewEvent {
                LoadingView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onDisappear {
            locationManager.pickedMark = nil
            locationManager.pickedLocation = nil
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(""), message: Text(viewModel.alertMessage),
                dismissButton: .default(Text(Constants.Labels.ok)
                    .foregroundColor(Constants.Colors.blueThemeColor)))
        }
    }
}


struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

//struct MapSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewSelection(viewModel: AddEventViewModel())
//    }
//}
