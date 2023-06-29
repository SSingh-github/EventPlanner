//
//  DatePickerTextField.swift
//  EventPlanner
//
//  Created by Chicmic on 26/06/23.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    
    //MARK: PROPERTIES
    
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatterForDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  Constants.StringFormats.dateFormat
        return dateFormatter
    }()
    
    private let dateFormatterForTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.timeFormat2
        return dateFormatter
    }()
    
    public var placeholder: String
    
    @Binding public var date: Date?
    var pickerType: PickerType
    var minimumDate: Date?
    var maximumDate: Date?
    
    //MARK: METHODS
    
    func makeUIView(context: Context) -> UITextField {
        
        self.datePicker.datePickerMode = self.pickerType == .date ? .date : .time
        self.datePicker.preferredDatePickerStyle = .wheels
        
        if self.minimumDate != nil {
            self.datePicker.minimumDate = self.minimumDate
        }
        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        textField.tintColor = UIColor.clear
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .secondarySystemBackground
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: Constants.Labels.done, style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        doneButton.tintColor = Constants.Colors.polylineColor
        self.textField.inputAccessoryView = toolbar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
        }
        
        self.helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.pickerType == .date ? self.dateFormatterForDate.string(from: selectedDate) : self.dateFormatterForTime.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    //MARK: HELPER CLASS
    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}
