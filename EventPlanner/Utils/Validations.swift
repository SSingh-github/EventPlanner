//
//  Validations.swift
//  BlaBla
//
//  Created by Chicmic on 12/05/23.
//


///This singleton contains all the functions for various validations required in the app using regular expressions.
 

import Foundation

class Validations {
    
    private init() {}
    
    static let shared = Validations()
    //MARK: METHODS
    
    ///checks the email passed as parameter against the regex for email and returns the corresponding boolean value.
    ///
    ///  - Parameters:
    ///     - email: email in the string format
    ///
    ///  - Returns: true if the email passed is valid, and false otherwise
    ///
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Constants.Regex.emailRegex
        let emailPredicate = NSPredicate(format:Constants.Regex.predicateFormat, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    ///checks the password passed as parameter against the regex for password and returns the corresponding boolean value.
    ///
    ///   - Parameters:
    ///     - password: password to be validated in the string format
    ///
    ///   - Returns: true if the password is in the valid format, and false otherwise
    ///
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = Constants.Regex.passwordRegex
        let passwordPredicate = NSPredicate(format: Constants.Regex.predicateFormat, passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    ///checks the firstname passed as parameter against the regex for first name and returns the corresponding boolean value.
    ///
    ///   - Parameters:
    ///      - firstName: contains the first name of the user.
    ///
    ///   - Returns: true if the first name of the user is in the valid format and false otherwise.
    ///
    func isValidFirstName(_ firstName:String) -> Bool {
        let firstNameRegex = Constants.Regex.firstNameRegex
        let firstNamePredicate = NSPredicate(format:Constants.Regex.predicateFormat, firstNameRegex)
        return firstNamePredicate.evaluate(with: firstName)
    }
    
    ///checks the lastname passed as parameter against the regex for the last name and returns the corresponding boolean value.
    ///
    ///   - Parameters:
    ///     - lastName: represents the last name of the user in string format.
    ///
    ///   - Returns: true if the last name of the user is in the valid format and false otherwise.
    ///
    func isValidLastName(_ lastName:String) -> Bool {
        let lastNameRegex = Constants.Regex.lastNameRegex
        let lastNamePredicate = NSPredicate(format: Constants.Regex.predicateFormat, lastNameRegex)
        return lastNamePredicate.evaluate(with: lastName)
    }
    
    ///checks the dob passed as parameter against the regex for dob and returns the corresponding boolean value.
    ///
    ///   - Parameters:
    ///     - dob: represents the date of birth of the user in the string format
    ///
    ///   - Returns: true if the date of birth of the user is in the valid format and false otherwise.
    ///
    func isValidDob(_ dob: String) -> Bool {
        let dobRegex = Constants.Regex.dobRegex
        let dobPredicate = NSPredicate(format: Constants.Regex.predicateFormat, dobRegex)
        return dobPredicate.evaluate(with: dob)
    }
    
    ///checks the phoneNumber passed as parameter against the regex for the phoneNumber and returns the corresponding boolean value.
    ///
    ///   - Parameters:
    ///      - phoneNumber: represents the phone number of the user in string format
    ///
    ///   - Returns: true if the phone number of the user is in the valid format and false otherwise.
    ///   
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = Constants.Regex.phoneNumberRegex
        let phoneNumberPredicate = NSPredicate(format: Constants.Regex.predicateFormat, phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
}
