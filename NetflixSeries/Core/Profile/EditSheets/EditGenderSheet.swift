//
//  EditGenderSheet.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 01.04.2023.
//

import SwiftUI

struct EditGenderSheet: View {
    
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @StateObject var vm: ProfileViewModel = ProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            whiteRectangle
            
            Spacer()
            
            title
            newGenderPicker
                            
            Spacer()
            
            saveButton
        }
        .presentationDetents([.fraction(0.7)])
        .presentationDragIndicator(.hidden)
    }
}

struct EditGenderSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditGenderSheet()
    }
}

private extension EditGenderSheet {
    var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.white)
            .frame(width: 40, height: 5)
            .padding()
    }
    
    var title: some View {
        Text("Did you wanna reselect gender?")
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .padding(.bottom,10)
    }
    
    var newGenderPicker: some View {
        Picker(selection: $vm.editedGender, content: {
            Text("Not selected").tag("Not Selected")
            Text("Female").tag("Female")
            Text("Male").tag("Male")
            Text("Non-Binary").tag("Non-Binary")
            
        }, label: {
            Text("Select a gender")
        })
        .pickerStyle(.wheel)
        .accentColor(Color.white)
        .foregroundColor(Color.white)
        .padding(.vertical, 0)
        .padding(.horizontal)
    }
    
    var saveButton: some View {
        Button {
            if !vm.editedGender.isEmpty {
                onboardingVM.currentUserGender = vm.editedGender
//                vm.showSheetForEditGender = false
//                vm.activeSheet = nil
                dismiss()
            } else {
                vm.editedGenderIsValid = true
            }
            
        } label: {
            Text("SAVE")
                .foregroundColor(Color.black)
                .font(.system(.title, design: .rounded, weight: .medium))
                .frame(width: 310, height: 50)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom)
                .opacity(vm.editedGender.isEmpty ? 0.5 : 1)
                .alert(isPresented: $vm.editedGenderIsValid) {
                    Alert(title: Text("Gender not selected"), message: Text("You need to select your gender in order to make changes! 🙈"))
                }
        }
    }
    
}
