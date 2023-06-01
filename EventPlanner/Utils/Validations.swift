//
//  Validations.swift
//  BlaBla
//
//  Created by Chicmic on 12/05/23.
//

import Foundation

class Validations {
    
    private init() {}
    
    static let shared = Validations()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Constants.Regex.emailRegex
        let emailPredicate = NSPredicate(format:Constants.Regex.predicateFormat, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = Constants.Regex.passwordRegex
        let passwordPredicate = NSPredicate(format: Constants.Regex.predicateFormat, passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidFirstName(_ firstName:String) -> Bool {
        let firstNameRegex = Constants.Regex.firstNameRegex
        let firstNamePredicate = NSPredicate(format:Constants.Regex.predicateFormat, firstNameRegex)
        return firstNamePredicate.evaluate(with: firstName)
    }
    
    func isValidLastName(_ lastName:String) -> Bool {
        let lastNameRegex = Constants.Regex.lastNameRegex
        let lastNamePredicate = NSPredicate(format: Constants.Regex.predicateFormat, lastNameRegex)
        return lastNamePredicate.evaluate(with: lastName)
    }
    
    func isValidDob(_ dob: String) -> Bool {
        let dobRegex = Constants.Regex.dobRegex
        let dobPredicate = NSPredicate(format: Constants.Regex.predicateFormat, dobRegex)
        return dobPredicate.evaluate(with: dob)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = Constants.Regex.phoneNumberRegex
        let phoneNumberPredicate = NSPredicate(format: Constants.Regex.predicateFormat, phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
}
