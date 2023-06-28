//
//  TextFieldPickerAsInput.swift
//  EventPlanner
//
//  Created by Chicmic on 19/06/23.
//

import Foundation
import SwiftUI

struct TextFieldWithPickerAsInputView : UIViewRepresentable {
    
    //MARK: PROPERTIES
    var data : [String]
    var placeholder : String
    
    @Binding var selectionIndex : Int
    @Binding var text : String?
    
    private let textField = UITextField()
    private let picker = UIPickerView()
    private let helper = Helper()
    
    
    //MARK: METHODS
    func makeCoordinator() -> TextFieldWithPickerAsInputView.Coordinator {
        Coordinator(textfield: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldWithPickerAsInputView>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.inputView = picker
        textField.delegate = context.coordinator
        textField.tintColor = UIColor.clear
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: Constants.Labels.done, style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.helper.doneButtonTapped = {
            self.textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithPickerAsInputView>) {
        uiView.text = text
    }
    
    //MARK: HELPER CLASS
    class Helper {
        public var doneButtonTapped: (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    //MARK: COORDINATOR CLASS
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {
        
        //MARK: PROPERTIES
        private let parent : TextFieldWithPickerAsInputView
        
        //MARK: INITIALIZER
        init(textfield : TextFieldWithPickerAsInputView) {
            self.parent = textfield
        }
        
        //MARK: METHODS
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.$selectionIndex.wrappedValue = row
            self.parent.text = self.parent.data[self.parent.selectionIndex]
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
           
        }
    }
}
