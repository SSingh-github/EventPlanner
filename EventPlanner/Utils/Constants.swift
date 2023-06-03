//
//  Constants.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import Foundation
import SwiftUI

struct Constants {
    struct Colors {
        static let blueThemeColor = Color(red: 0.04, green: 0.33, blue: 1.81)
    }
    
    struct API {
        static let requestValueType = "application/json"
        static let contentTypeHeaderField = "Content-type"
        static let authorizationHeaderField = "Authorization"
        struct URLs {
            static private let baseUrl = "https://b9ad-112-196-113-2.ngrok-free.app/users/"
            static let signUp = baseUrl + "signup/"
            static let logIn = baseUrl + "login/"
            static let logOut = baseUrl + "logout/"
            static let forgotPassword = baseUrl + "forgotpassword/"
            static let verifyOtp = baseUrl + "verifyotp/"
            static let resetPassword = baseUrl + "resetpassword/" //put
            static let setProfile = baseUrl + "profile/"
            static let getProfile = baseUrl + "profile/"
            static let updateProfile = baseUrl + "updateprofile/"
        }
        
        struct HttpMethods {
            static let post = "POST"
            static let put = "PUT"
            static let get = "GET"
        }
    }
    
    struct Regex {
        static let firstNameRegex = "^[a-zA-Z]+$"
        static let lastNameRegex = "^[a-zA-Z]+(-[a-zA-Z]+)*$"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
        static let dobRegex = "^(19[2-9][0-9]|200[0-5])-(0[1-9]|1[0-2])-([0-2][1-9]|3[0-1])$"
        static let phoneNumberRegex = "^[1-9]\\d{9}$"
        static let predicateFormat = "SELF MATCHES %@"
    }
    
    struct Images {
        static let carsImage = "cars"
        static let xmark = "xmark"
        static let envelope = "envelope"
        static let facebook = "f.circle.fill"
        static let appleLogo = "apple.logo"
        static let search = "magnifyingglass"
        static let plusCircle = "plus.circle"
        static let car = "car.side"
        static let message = "message"
        static let person = "person"
        static let personFill = "person.circle.fill"
        static let calendar = "calendar"
        static let circle = "circle"
        static let travelPlan = "travelPlan"
        static let minusCircle = "minus.circle"
        static let rightArrowWithCircle = "arrow.right.circle.fill"
        static let home = "house"
        static let addEvent = "plus.circle"
        static let list = "list.bullet"
        static let profile = "person"
        static let explore = "safari"
        static let edit = "pencil"
    }
    
    struct Labels {
        static let authToken = "token"
        static let editProfile = "Edit Profile"
        static let resendOtp = "Resend OTP"
        static let verify = "Verify"
        static let enterNewPassword = "Set new password"
        static let enterPassword = "Enter new password:"
        static let confirmPassword = "Confirm password:"
        static let enterOtp = "Enter the OTP"
        static let sendOtp = "Send OTP"
        static let enterEmail = "Enter your email:"
        static let otpMessage = "The OTP will be sent to your email. Please check your email inbox for getting the OTP to proceed further and reset your account password"
        static let loading = "Loading..."
        static let userLoggedIn = "userLoggedIn"
        static let new = "New"
        static let explore = "Explore"
        static let profile = "Profile"
        static let list = "My Events"
        static let guestLoginKey = "guestLogin"
        static let guestLogin = "continue as a guest"
        static let getStarted = "Get Started"
        static let forgotPassword = "Forgot Password?"
        static let changePassword = "Reset Password"
        static let pickRides = "Your pick of rides at\nlow prices"
        static let signUp = "Sign Up"
        static let skip = "Skip"
        static let logIn = "Login"
        static let signUpQuery = "Sign Up with your email to get started."
        static let logInQuery = "Login with your email to get started."
        static let signUpButtonLabel = "Sign up with your email"
        static let logInButtonLabel = "continue with email"
        static let alreadyMember = "Already a member?"
        static let notMember = "Not a member yet?"
        static let tabSearch = "Search"
        static let tabPublish = "Publish"
        static let tabRides = "Your rides"
        static let tabInbox = "Inbox"
        static let tabProfile = "Profile"
        static let leavingFrom = "Leaving From"
        static let goingTo = "Going to"
        static let futurePlan = "Your future plans will appear here"
        static let findPerfectRide = "Find the perfect ride from thousands of destinations, or publish to share your travel costs."
        static let numberOfSeatsToBook = "Number of seats to\nbook"
        static let done = "Done"
        static let addVehicle = "Add vehicle"
        static let vehicles = "Vehicles"
        static let addPreferences = "Add my preferences"
        static let addMiniBio = "Add a mini bio"
        static let aboutYou = "About you"
        static let confirmPhone = "Confirm phone number"
        static let confirmEmail = "Confirm email"
        static let editPersonalDetails = "Edit personal details"
        static let verifyProfile = "Verify your profile"
        static let verifyId = "Verify my ID"
        static let passwordRule = "It must have at least 8 characters, 1 uppercase letter, 1 lowecase letter, 1 number, and 1 special character."
        static let phoneRule = "Enter 10-digit phone number"
        static let createAccount = "Let's create your account"
        static let ok = "OK"
        
        struct Questions {
            static let name = "What's your name?"
            static let emailPassword = "What's your email and password?"
            static let dob = "What's your date of birth?"
            static let phone = "What's your phone number?"
            static let address = "What's your address?"
            static let logout = "Do you really want to logout?"
        }
        
        struct Warnings {
            static let name = "Please enter valid name"
            static let password = "Please enter valid password"
            static let dob = "Please enter valid date of birth"
            static let email = "Please enter valid email"
            static let phoneNumber = "Please enter valid phone number"
            static let confirmPassword = "Passwords do not match"
        }
        
        struct Alerts {
            static let alertMessage = "Something went wrong"
            static let cancel = "Cancel"
        }
        
        struct Placeholders {
            static let title = "Title"
            static let phoneNumber = "Phone number"
            static let dob = "yyyy-mm-dd"
            static let password = "Password"
            static let email = "Email"
            static let firstName = "First name"
            static let lastName = "Last name"
            static let otp = "Enter 4 digit OTP"
            static let address = "Address"
        }
    }
    
    struct StringFormats {
        static let dateFormat = "dd/MM/yyyy"
    }

    
}

