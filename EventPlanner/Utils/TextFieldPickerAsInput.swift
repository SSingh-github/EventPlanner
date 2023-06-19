//
//  TextFieldPickerAsInput.swift
//  EventPlanner
//
//  Created by Chicmic on 19/06/23.
//

import Foundation
import SwiftUI

struct TextFieldWithPickerAsInputView : UIViewRepresentable {
    
    var data : [String]
    var placeholder : String
    
    @Binding var selectionIndex : Int
    @Binding var text : String?
    
    private let textField = UITextField()
    private let picker = UIPickerView()
    private let helper = Helper()
    
    func makeCoordinator() -> TextFieldWithPickerAsInputView.Coordinator {
        Coordinator(textfield: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldWithPickerAsInputView>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        //picker.backgroundColor = .yellow
        picker.tintColor = .black
        textField.placeholder = placeholder
        textField.inputView = picker
        textField.delegate = context.coordinator
        textField.tintColor = UIColor.clear
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
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
    
    class Helper {
        public var doneButtonTapped: (() -> Void)?
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {
        
        private let parent : TextFieldWithPickerAsInputView
        
        init(textfield : TextFieldWithPickerAsInputView) {
            self.parent = textfield
        }
        
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
            self.parent.textField.endEditing(true)
            
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }
    }
}
