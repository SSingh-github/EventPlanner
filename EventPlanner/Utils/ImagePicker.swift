//
//  ImagePicker.swift
//  EventPlanner
//
//  Created by Chicmic on 02/06/23.
//

import Foundation
import SwiftUI
import PhotosUI
import UIKit


class ImagePicker: ObservableObject {
    //MARK: PROPERTIES
    
    @Published var image: UIImage?
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    //MARK: METHODS
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.image = uiImage
                }
            }
        }
        catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}
