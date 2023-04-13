//
//  OnboardingView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI
import CoreLocationUI

struct OnboardingView: View {
    
    @StateObject private var vm: OnboardingViewModel = OnboardingViewModel()
    @StateObject var locationManager: LocationManager = LocationManager.shared
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
            VStack {
                switch vm.onboardingState {
                case 0:
                    welcomeScreen
                        .transition(vm.transition)
                case 1:
                    nameScreen
                        .transition(vm.transition)
                case 2:
                    ageScreen
                        .transition(vm.transition)
                case 3:
                    genderScreen
                        .transition(vm.transition)
                case 4:
                    countryScreen
                        .transition(vm.transition)
                default:
                    welcomeScreen
                        .transition(vm.transition)
                }
                bottomButton
                Spacer()

            }
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

// MARK: COMPONENTS
extension OnboardingView {
    
    
    // MARK: bottomButton
    private var bottomButton: some View {
        Button {
            vm.showNextOnboardingScreen()
        } label: {
            Text(vm.onboardingState == 0 ? "SIGN UP" :
                    vm.onboardingState == 4 ? "FINISH" :
                    "CONTINUE")
            .foregroundColor(Color.black)
            .font(.system(.title, design: .rounded, weight: .medium))
            .frame(width: 310, height: 50)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.bottom)
            .opacity(vm.onboardingState != 1 ? 1 : !vm.nameIsValid ? 0.5 : 1)
            .transaction { transaction in
                transaction.animation = nil
            }
            .alert(isPresented: $vm.alertForName) {
                Alert(title: Text("Wrong name"), message: Text("Your name must be min of 2 characters long and max of 12 short! 🙁"))
                    
            }
        }
    }
    
    // MARK: welcomeScreen
    private var welcomeScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            NetflixLogo()
            
            OnboardingQuestion(questionString: "Welcome to Netflix")
            
            Text("We are by far the best streaming service in the world right now. We have a huge selection of movies and TV shows old and new, tons of high-quality original programs, and an easy-to-navigate interface.")
                .foregroundColor(Color.white)
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .multilineTextAlignment(.center)
            
            Spacer()
        }.padding()
    }
    
    // MARK: nameScreen
    private var nameScreen: some View {
        VStack(spacing: 60) {
            
            Spacer()
            NetflixLogo()
            OnboardingQuestion(questionString: "What's your name?")
            
            TextField("", text: $vm.name, prompt: Text("Type in your name...").foregroundColor(Color.black))
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundColor(Color.black)
                .tint(.black)
                .padding(.horizontal, 40)
                .frame(height: 40)
                .background(Color.white.opacity(1))
                .cornerRadius(10)
                .autocorrectionDisabled()
                .padding(.horizontal, 15)
                .padding(.vertical, 40)
                .overlay(alignment: .trailing) {
                    ZStack {
                        if !vm.name.isEmpty {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.red)
                                .opacity(vm.nameIsValid ? 0 : 1)
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.green)
                                .opacity(vm.nameIsValid ? 1 : 0)
                        }
                    }
                    .padding(.trailing, 30)
                    .font(.system(.title2, weight: .semibold))
                }
            //Spacer()
            Spacer()
        }
        .padding()
    }
    
    // MARK: ageScreen
    private var ageScreen: some View {
        VStack(spacing: 60) {
            Spacer()
            
            NetflixLogo()
            
            OnboardingQuestion(questionString: "What's your age?")
            
            Text("Your age is: \(String(format: "%.0f", vm.age))")
                .foregroundColor(Color.white)
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            Slider(value: $vm.age,
                   in: 18...100, step: 1) {
            } minimumValueLabel: {
                Text("18")
                    .foregroundColor(Color.white)
                    .font(.system(.headline, design: .rounded, weight: .bold))
            } maximumValueLabel: {
                Text("100")
                    .foregroundColor(Color.white)
                    .font(.system(.headline, design: .rounded, weight: .bold))
            }
            .accentColor(Color.white)
             
            //Spacer()
            Spacer()
        }
        .padding()
    }
    
    // MARK: genderScreen
    private var genderScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            NetflixLogo()
                .padding(.top, 60)
            
            OnboardingQuestion(questionString: "What's your gender?")
            
            Picker(selection: $vm.gender, content: {
                Text("Not selected").tag("Not Selected")
                Text("Female").tag("Female")
                Text("Male").tag("Male")
                Text("Non-Binary").tag("Non-Binary")
                
            }, label: {
                Text("Select a gender")
            })
            .pickerStyle(.wheel)
            .font(.title)
            .accentColor(Color.white)
            .foregroundColor(Color.white)
            .padding(.vertical, 0)
            
            Spacer()
            Spacer()
            
        }
        .padding()
    }
    
    // MARK: countryScreen
    private var countryScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            NetflixLogo()
                .padding(.top, 60)

            OnboardingQuestion(questionString: "Your current location?")
            
            Text("country:   \(locationManager.country == nil ? vm.currentUserCountry ?? "" : locationManager.country ?? "")")
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            Spacer()
            
            Button {
                Task {
                    try await locationManager.getCountryFromCurrentLocation()
                }
            } label: {
                LocationButton(.shareMyCurrentLocation) {
                    
                }
                .labelStyle(.titleOnly)
                .font(.headline)
                .tint(.black)
                .foregroundColor(.red)
            }
            
            Rectangle()
                .frame(width: 160, height: 2)
                .foregroundColor(Color.white)
                .padding(.bottom, 10)
            
            Button {
                vm.showListOfCountries = true
            } label: {
                Text("Manually select a country ")
                    .font(.system(.headline, design: .rounded, weight: .medium))
                    .foregroundColor(.red)
            }
            .disabled(locationManager.country == nil ? false : true)
            .fullScreenCover(isPresented: $vm.showListOfCountries) {
                ListOfCountries()
            }
            
            Spacer()
            
        }
        .padding()
    }
}
