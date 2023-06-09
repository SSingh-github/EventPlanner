//
//  Constants.swift
//  EventPlanner
//
//  Created by Chicmic on 29/05/23.
//

import Foundation
import SwiftUI

//MARK: Collection of all constants for the app

struct Constants {
    
    //MARK: Constants for colors
    
    struct Colors {
        static let blueThemeColor                       = Color(red: 0.04, green: 0.33, blue: 1.81)
        static let pinkColor                            = Color(red: 2.45, green: 0.05, blue: 0.77)
        static let polylineColor                        = UIColor(red: 0.04, green: 0.33, blue: 1.81, alpha: 1)
    }
    
    //MARK: Constants for API
    
    struct API {
        static let requestValueType                     = "application/json"
        static let contentTypeHeaderField               = "Content-type"
        static let authorizationHeaderField             = "Authorization"
        
        //MARK: URLs
        struct URLs {
            static let baseUrl                          = "http://192.180.1.206:5000/"
            static let signUp                           = baseUrl + "users/sign_up"
            static let logIn                            = baseUrl + "users/sign_in"
            static let logOut                           = baseUrl + "users/sign_out"
            static let forgotPassword                   = baseUrl + "users/forgot_password"
            static let verifyOtp                        = baseUrl + "users/verify_otp"
            static let resetPassword                    = baseUrl + "users/reset_password"
            static let setProfile                       = baseUrl + "profile"
            static let getProfile                       = baseUrl + "user_profile"
            static let updateProfile                    = baseUrl + "update_profile"
            static let postEvent                        = baseUrl + "events/"
            static let likeEvent                        = baseUrl + "like_event"
            static let markFavEvent                     = baseUrl + "favourites/"
            static let myEvents                         = baseUrl + "user_events"
            static let joinEvent                        = baseUrl + "join_event"
            static let followUser                       = baseUrl + "follow_user"
            static let favouriteEvents                  = baseUrl + "favourites/"
            static let joinedEvents                     = baseUrl + "user_joined_events"
        }
        
        //MARK: Http Methods
        struct HttpMethods {
            static let post                             = "POST"
            static let put                              = "PUT"
            static let get                              = "GET"
            static let delete                           = "DELETE"
        }
    }
    
    //MARK: Keys used in the app
    
    struct Keys {
        static let id                                   = "id"
        static let eventId                              = "event_id"
        static let email                                = "email"
        static let password                             = "password"
        static let otp                                  = "otp"
        static let firstName                            = "first_name"
        static let lastName                             = "last_name"
        static let dob                                  = "dob"
        static let phoneNumber                          = "phone_number"
        static let address                              = "address"
        static let eventCategoryId                      = "event_category_id"
        static let title                                = "title"
        static let description                          = "description"
        static let location                             = "location"
        static let latitude                             = "latitude"
        static let longitude                            = "longitude"
        static let startDate                            = "start_date"
        static let startTime                            = "start_time"
        static let endDate                              = "end_date"
        static let endTime                              = "end_time"
        static let hashtags                             = "hashtags"
    }
    
    //MARK: Regular expressions
    struct Regex {
        static let firstNameRegex                       = "^[a-zA-Z]+( [a-zA-Z]+)?$"
        static let lastNameRegex                        = "^[a-zA-Z]+(-[a-zA-Z]+)*$"
        static let emailRegex                           = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let passwordRegex                        = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
        static let dobRegex                             = "^(19[2-9][0-9]|200[0-5])-(0[1-9]|1[0-2])-([0-2][1-9]|3[0-1])$"
        static let phoneNumberRegex                     = "^[1-9]\\d{9}$"
        static let predicateFormat                      = "SELF MATCHES %@"
    }
    
    //MARK: Image names
    struct Images {
        static let photoRectangle                       = "photo.on.rectangle"
        static let clock                                = "clock"
        static let locationSquare                       = "location.square.fill"
        static let slider                               = "slider.horizontal.3"
        static let listFill                             = "list.bullet.clipboard.fill"
        static let eventPlanner                         = "eventplanner"
        static let hourGlass                            = "hourglass"
        static let checkMark                            = "checkmark.circle.fill"
        static let starFill                             = "star.fill"
        static let star                                 = "star"
        static let heartFill                            = "heart.fill"
        static let heart                                = "heart"
        static let directions                           = "arrow.triangle.turn.up.right.diamond.fill"
        static let multiply                             = "multiply.circle.fill"
        static let rightArrow                           = "arrow.right"
        static let northLocation                        = "location.north.circle.fill"
        static let mappin                               = "mappin.circle.fill"
        static let location                             = "Location"
        static let eyeSlash                             = "eye.slash.fill"
        static let eye                                  = "eye.fill"
        static let carsImage                            = "cars"
        static let xmark                                = "xmark"
        static let envelope                             = "envelope"
        static let facebook                             = "f.circle.fill"
        static let appleLogo                            = "apple.logo"
        static let search                               = "magnifyingglass"
        static let plusCircle                           = "plus.circle"
        static let car                                  = "car.side"
        static let message                              = "message"
        static let person                               = "person"
        static let personFill                           = "person.circle.fill"
        static let calendar                             = "calendar"
        static let circle                               = "circle"
        static let circleFill                           = "circle.fill"
        static let travelPlan                           = "travelPlan"
        static let minusCircle                          = "minus.circle"
        static let rightArrowWithCircle                 = "arrow.right.circle.fill"
        static let home                                 = "house"
        static let addEvent                             = "plus.circle"
        static let addHashtag                           = "plus.circle.fill"
        static let list                                 = "list.bullet"
        static let profile                              = "person"
        static let explore                              = "safari"
        static let edit                                 = "pencil"
        static let logout                               = "rectangle.portrait.and.arrow.right.fill"
        static let settings                             = "gearshape.fill"
        static let phone                                = "phone"
        static let calendarExclamation                  = "calendar.badge.exclamationmark"
        static let rectanglePencil                      = "rectangle.and.pencil.and.ellipsis"
        static let person2                              = "person.2.fill"
        static let checkmark                            = "checkmark.square.fill"
        static let square                               = "square"
        static let docFill                              = "doc.on.doc.fill"
    }
    
    //MARK: Labels for the app
    struct Labels {
        static let invalid                              = "invalid"
        static let noHashtags                           = "no hashtags"
        static let start                                = "Start"
        static let event                                = "Event"
        static let eventCalendar                        = "Event Calendar"
        static let cancel                               = "Cancel"
        static let showResults                          = "Show results"
        static let filter                               = "Filter"
        static let reset                                = "Reset"
        static let favouriteEvents                      = "Events marked favourite by you will be visible here"
        static let joinedEvents                         = "Events joined by you will be visible here"
        static let createdEvents                        = "Events created by you will be visible here"
        static let delete                               = "Delete"
        static let upcomingEvents                       = "upcoming events for you will be visible here"
        static let navTag                               = "MAPVIEW"
        static let useSameLocation                      = "Use same location"
        static let changeLocation                       = "Change location"
        static let createEvent                          = "Create Event"
        static let updateEvent                          = "Update Event"
        static let addHashtag                           = "Add Hashtag"
        static let giveDescription                      = "Give the description"
        static let description                          = "Description"
        static let updateProfile                        = "Update profile"
        static let approvedLable                        = "(Approved)"
        static let notApprovedLable                     = "(Not Approved)"
        static let attendees                            = "attendees "
        static let liked                                = "Liked"
        static let notLiked                             = "Not liked"
        static let favourite                            = "favourite"
        static let notFavourite                         = "Not favourite"
        static let Commencement                         = "Commencement"
        static let culmination                          = "Culmination"
        static let followers                            = "followers "
        static let follow                               = "follow"
        static let following                            = "following"
        static let joinEvent                            = "Join event"
        static let joined                               = "Joined"
        static let leave                                = "Leave"
        static let join                                 = "Join"
        static let edit                                 = "Edit"
        static let hashtag                              = "Hashtag:"
        static let km                                   = " Km"
        static let radius                               = "Radius: "
        static let location                             = "Location:"
        static let title                                = "Title:"
        static let startDate                            = "Start Date:"
        static let eventsNearYou                        = "Events near you will be visible here"
        static let eventPlanner                         = "Event Planner"
        static let pending                              = "pending  "
        static let approved                             = "approved"
        static let addDescription                       = "Add some description"
        static let selectOption                         = "Select an option"
        static let category                             = "Category"
        static let selectCategory                       = "Select Category"
        static let directions                           = "Directions"
        static let startingLocation                     = "Starting location"
        static let destinationLocation                  = "Destination location"
        static let done                                 = "Done"
        static let selectStartTime                      = "Select the Start time:"
        static let selectEndTime                        = "Select the End time:"
        static let dateAndTime                          = "Date and Time"
        static let currentLocation                      = "Current Location"
        static let confirmLocation                      = "Confirm Location"
        static let useCurrentLocation                   = "  use current location"
        static let searchResults                        = "Your Search results will appear here"
        static let selectDob                            = "Select your date of birth"
        static let phoneNumber                          = "Phone number"
        static let address                              = "Address"
        static let dateOfBirth                          = "Date of birth"
        static let eventsForYou                         = "Events for you"
        static let settings                             = " Settings"
        static let editProfileWithSpace                 = "  Edit profile"
        static let segments                             = ["Start", "End"]
        static let options                              = ["Favourite events", "Joined Events", "Created Events", "Upcoming"]
        static let eventTypes                           = ["Social", "Corporate", "Cultural / Artistic", "Sports / recreation", "Edu. / Academic"]
        static let months                               = ["01":"Jan", "02":"Feb", "03":"Mar", "04":"Apr", "05":"May", "06":"Jun", "07":"Jul", "08":"Aug", "09":"Sep", "10":"Oct", "11":"Nov", "12":"Dec"]
        static let authToken                            = "token"
        static let createProfile                        = "Create Profile"
        static let editProfile                          = "Edit Profile"
        static let resendOtp                            = "Resend OTP"
        static let verify                               = "Verify"
        static let enterNewPassword                     = "Set new password"
        static let enterPassword                        = "Enter new password:"
        static let confirmPassword                      = "Confirm password:"
        static let enterOtp                             = "Enter the OTP"
        static let sendOtp                              = "Send OTP"
        static let enterEmail                           = "Enter your email:"
        static let durationMessage                      = "Note: The total duration of the event must be atleast 1 hour."
        static let otpMessage                           = "The OTP will be sent to your email. Please check your email inbox for getting the OTP to proceed further and reset your account password"
        static let loading                              = "Loading..."
        static let userLoggedIn                         = "userLoggedIn"
        static let new                                  = "New"
        static let explore                              = "Explore"
        static let profile                              = "Profile"
        static let list                                 = "My Events"
        static let guestLoginKey                        = "guestLogin"
        static let guestLogin                           = "continue as a guest"
        static let getStarted                           = "Get Started"
        static let forgotPassword                       = "Forgot Password?"
        static let changePassword                       = "Reset Password"
        static let signUp                               = "Sign Up"
        static let skip                                 = "Skip"
        static let logOut                               = "Logout"
        static let logIn                                = "Login"
        static let signUpQuery                          = "Sign Up with your email to get started."
        static let logInQuery                           = "Login with your email to get started."
        static let signUpButtonLabel                    = "Sign up with your email"
        static let logInButtonLabel                     = "continue with email"
        static let alreadyMember                        = "Already a member?"
        static let notMember                            = "Not a member yet?"
        static let tabSearch                            = "Search"
        static let confirmPhone                         = "Confirm phone number"
        static let confirmEmail                         = "Confirm email"
        static let editPersonalDetails                  = "Edit personal details"
        static let verifyProfile                        = "Verify your profile"
        static let verifyId                             = "Verify my ID"
        static let passwordRule                         = "It must have at least 8 characters, 1 uppercase letter, 1 lowecase letter, 1 number, and 1 special character."
        static let phoneRule                            = "Enter 10-digit phone number"
        static let createAccount                        = "Let's create your account"
        static let ok                                   = "OK"
        static let Continue                             = "Continue"
        static let noTitle                              = "no title"
        static let noDescription                        = "no description"
        static let noLocation                           = "no location"
        static let selectDOB                           = "Select D.O.B "
        static let eventLocation                        = "This will be the event location."
        static let eventPin                             = "EVENTPIN"
        
        //MARK: labels which are questions
        struct Questions {
            static let updateEvent                      = "Do you really want to update the event?"
            static let updateProfile                    = "Do you really want to update the profile?"
            static let leaveEvent                       = "Do you really want to leave the event?"
            static let joinEvent                        = "Do you really want to join the event?"
            static let title                            = "What's the title?"
            static let name                             = "What's your name?"
            static let emailPassword                    = "What's your email and password?"
            static let dob                              = "What's your date of birth?"
            static let phone                            = "What's your phone number?"
            static let address                          = "What's your address?"
            static let logout                           = "Do you really want to logout?"
            static let delete                           = "Do you really want to delete the event?"
            static let location                         = "Do you want to use the same location?"
            static let deleteEvent                      = "Do you want to delete the event?"
        }
       
        //MARK: labels which are warnings
        struct Warnings {
            static let name                             = "* please enter valid name"
            static let password                         = "* please enter valid password"
            static let dob                              = "* please enter valid date of birth"
            static let email                            = "* please enter valid email"
            static let phoneNumber                      = "* please enter valid phone number"
            static let confirmPassword                  = "* passwords do not match"
        }
        
        //MARK: Labels for alerts
        struct Alerts {
            static let alertMessage                     = "Something went wrong"
            static let cancel                           = "Cancel"
        }
        
        //MARK: lables as placeholders
        struct Placeholders {
            static let hashtag                          = "# hashtag"
            static let selectCategory                   = "Select Category"
            static let location                         = "Location"
            static let tag                              = "#tag"
            static let eventTitle                       = "Event title"
            static let title                            = "Title"
            static let phoneNumber                      = "Phone number"
            static let dob                              = "yyyy-mm-dd"
            static let confirmPassword                  = "Confirm Password"
            static let password                         = "Password"
            static let email                            = "Email"
            static let firstName                        = "First name"
            static let lastName                         = "Last name"
            static let otp                              = "Enter 4 digit OTP"
            static let address                          = "Address"
            static let findLocation                     = "Find location here"
            static let startTime                        = "Start Time"
            static let endTime                          = "End Time"
            static let selectDate                       = "Select Date"
        }
    }
    
    //MARK: String formats
    struct StringFormats {
        static let dateFormat                           = "yyyy-MM-dd"
        static let timeFormat                           = "HH:mm"
        static let timeFormat2                          = "hh:mm a"
        static let timeFormat3                          = "HH:mm:ss"
        static let float                                = "%.1f"
    }

    
}

