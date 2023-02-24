//
//  OnboardingView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 23.02.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: PROPERTIES
    @State var onboardingState: Int = 0
    
    // FOR THE ALERT AND TRANSITIONS
    @State private var text: String = ""
    @State var alertForName: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    // ONBOARDING INPUTS
    @State var name: String = ""
    @State var age: Double = 28
    @State var gender: String = ""
    @State var nationality: String = ""
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("nationality") var currentUserNationality: String?
    @AppStorage("isSigned") var isSigned: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
            VStack {
                switch onboardingState {
                case 0:
                    WelcomeScreen
                        .transition(transition)
                case 1:
                    nameScreen
                        .transition(transition)
                case 2:
                    ageScreen
                        .transition(transition)
                case 3:
                    genderScreen
                        .transition(transition)
                case 4:
                    nationalityScreen
                        .transition(transition)
                default:
                    Text("hi")
                    
                }
                
                Spacer()
                BottomButton
            }
            
        }
    }
}

// MARK: PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

// MARK: COMPONENTS
extension OnboardingView {
    private var BottomButton: some View {
        Button {
            showNextOnboardingScreen()
        } label: {
            Text(onboardingState == 0 ? "SIGN UP" :
                    onboardingState == 4 ? "FINISH" :
                    "CONTINUE")
            .foregroundColor(Color.black)
            .font(.system(.title, design: .rounded, weight: .medium))
            .frame(width: 310, height: 50)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.bottom)
            .transaction { transaction in
                transaction.animation = nil
            }
            .alert(isPresented: $alertForName) {
                Alert(title: Text("Wrong name"), message: Text("Your name must be minimum of 2 characters long! 🙁"))
            }
        }
    }
    
    private var WelcomeScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(height: 140)
            
            
            Text("Welcome to Netflix")
                .foregroundColor(Color.white)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Text("We are by far the best streaming service in the world right now. We have a huge selection of movies and TV shows old and new, tons of high-quality original programs, and an easy-to-navigate interface.")
                .foregroundColor(Color.white)
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .multilineTextAlignment(.center)
            
            Spacer()
            
        }.padding()
    }
    
    private var nameScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(height: 170)
                .padding(.bottom, 50)
            
            Text("What's your name?")
                .foregroundColor(Color.white)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            TextField("", text: $name, prompt: Text("Type in your name...").foregroundColor(Color.black))
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundColor(Color.black)
                .padding(.horizontal, 40)
                .frame(height: 40)
                .background(Color.white.opacity(1))
                .cornerRadius(10)
                .padding(.horizontal)
         
            
            Spacer()
            Spacer()
            
        }.padding()
    }
    
    private var ageScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(height: 170)
                .padding(.bottom, 50)
            
            Text("What's your age?")
                .foregroundColor(Color.white)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            
            Text("Your age is: \(String(format: "%.0f", age))")
                .foregroundColor(Color.white)
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            Slider(value: $age,
                   in: 18...100, step: 1) {
            } minimumValueLabel: {
                Text("18")
                    .foregroundColor(Color.white)
                    .font(.system(.headline, design: .rounded, weight: .bold))
            } maximumValueLabel: {
                Text("100")
                    .foregroundColor(Color.white)
                    .font(.system(.headline, design: .rounded, weight: .bold))
            }.accentColor(Color.white)
            
            
            Spacer()
            Spacer()
            
        }.padding()
    }
    
    private var genderScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(height: 170)
                .padding(.bottom, 50)
            
            Text("What's your gender?")
                .foregroundColor(Color.white)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Picker(selection: $gender, content: {
                Text("female").tag("female")
                Text("male").tag("male")
                Text("Non-Binary").tag("Non-Binary")
                
            }, label: {
                Text("Select a gender")
            })
            .pickerStyle(.automatic)
            .font(.title)
            .accentColor(Color.white)
            .foregroundColor(Color.white)
            
            Spacer()
            Spacer()
            
        }.padding()
    }
    
    private var nationalityScreen: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Netflix")
                .resizable()
                .scaledToFit()
                .frame(height: 170)
                .padding(.bottom, 50)
            
            Text("What's your nationality?")
                .foregroundColor(Color.white)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            
            Picker(selection: $nationality, content: {
                ForEach(NSLocale.isoCountryCodes, id: \.self) { country in
                    HStack {
                        Text(Locale.current.localizedString(forRegionCode: country) ?? "")
                        //Text(country)
                        //Text(countryFlag(country))
                        
                        
                        
                    }
                }
                
            }, label: {
                Text("Select a nationality")
            })
            .pickerStyle(.menu)
            .font(.title)
            .accentColor(Color.white)
            .foregroundColor(Color.white)
            
            
            
            Spacer()
            Spacer()
            
        }.padding()
    }
    
}

// MARK: FUNCTIONS
extension OnboardingView {
    func showNextOnboardingScreen() {
        switch onboardingState {
        case 1:
            if name.count >= 2 {
                withAnimation(.spring()){
                    onboardingState += 1
                }
            }else {
                alertForName = true
                
            }
        case 4:
            signIn()
        default:
            withAnimation(.spring()){
                onboardingState += 1
            }
        }
    }
    
    func countryFlag(_ countryCode: String) -> String {
        String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        currentUserNationality = nationality
        withAnimation(.spring()) {
            isSigned = true
        }
    }
    
    
    
}

