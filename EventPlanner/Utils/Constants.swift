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
            static let baseUrl = "https://22f9-112-196-113-2.ngrok-free.app/"
            static let signUp = baseUrl + "users/sign_up"
            static let logIn = baseUrl + "users/sign_in"
            static let logOut = baseUrl + "users/sign_out"
            static let forgotPassword = baseUrl + "users/forgot_password"
            static let verifyOtp = baseUrl + "users/verify_otp"
            static let resetPassword = baseUrl + "users/reset_password" 
            static let setProfile = baseUrl + "profile"
            static let getProfile = baseUrl + "user_profile"
            static let updateProfile = baseUrl + "update_profile"
            static let postEvent = baseUrl + "events/"
            static let getEvents = "https://f501-112-196-113-2.ngrok-free.app/events/?user_latitude=30.711214&user_longitude=76.690276"
        }
        
        struct HttpMethods {
            static let post = "POST"
            static let put = "PUT"
            static let get = "GET"
        }
    }
    
    struct Keys {
        static let email = "email"
        static let password = "password"
        static let otp = "otp"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let dob = "dob"
        static let phoneNumber = "phone_number"
        static let address = "address"
        static let eventCategoryId = "event_category_id"
        static let title = "title"
        static let description = "description"
        static let location = "location"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let startDate = "start_date"
        static let startTime = "start_time"
        static let endDate = "end_date"
        static let endTime = "end_time"
        static let hashtags = "hashtags"
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
        static let rightArrow = "arrow.right"
        static let northLocation = "location.north.circle.fill"
        static let mappin = "mappin.circle.fill"
        static let location = "Location"
        static let eyeSlash = "eye.slash.fill"
        static let eye = "eye.fill"
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
        static let circleFill = "circle.fill"
        static let travelPlan = "travelPlan"
        static let minusCircle = "minus.circle"
        static let rightArrowWithCircle = "arrow.right.circle.fill"
        static let home = "house"
        static let addEvent = "plus.circle"
        static let list = "list.bullet"
        static let profile = "person"
        static let explore = "safari"
        static let edit = "pencil"
        static let logout = "rectangle.portrait.and.arrow.right.fill"
        static let settings = "gearshape.fill"
        static let phone = "phone"
    }
    
    struct Labels {
        static let selectStartTime = "Select the Start time:"
        static let selectEndTime = "Select the End time:"
        static let dateAndTime = "Date and Time"
        static let currentLocation = "Current Location"
        static let confirmLocation = "confirm location"
        static let useCurrentLocation = "  use current location"
        static let searchResults = "Your Search results will appear here"
        static let selectDob = "Select your date of birth"
        static let phoneNumber = "Phone number:"
        static let address = "Address:"
        static let dateOfBirth = "Date of birth:"
        static let eventsForYou = "Events for you"
        static let settings = " Settings"
        static let editProfileWithSpace = "  Edit profile"
        static let segments = ["Start", "End"]
        static let eventTypes = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
        static let authToken = "token"
        static let createProfile = "Create Profile"
        static let editProfile = "Edit Profile"
        static let resendOtp = "Resend OTP"
        static let verify = "Verify"
        static let enterNewPassword = "Set new password"
        static let enterPassword = "Enter new password:"
        static let confirmPassword = "Confirm password:"
        static let enterOtp = "Enter the OTP"
        static let sendOtp = "Send OTP"
        static let enterEmail = "Enter your email:"
        static let durationMessage = "Note: The total duration of the event must be atleast 1 hour."
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
        static let logOut = "Log out"
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
        static let Continue = "continue"
        
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
            static let findLocation = "Find location here"
        }
    }
    
    struct StringFormats {
        static let dateFormat = "yyyy-MM-dd"
        static let timeFormat = "HH:mm"
    }

    
}

