//
//  EditNameSheet.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 01.04.2023.
//

import SwiftUI

struct EditNameSheet: View {
    
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @StateObject var vm: ProfileViewModel = ProfileViewModel()
    
   // MARK: BODY
    var body: some View {
        VStack {
            whiteRectangle
            
            Spacer()
            
            title
            newNameTextfield
            
            Spacer()
            
            saveButton
        }
        .presentationDetents([.fraction(0.7)])
        .presentationDragIndicator(.hidden)
    }
}

struct EditNameSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditNameSheet()
    }
}

// MARK: COMPONENTS
private extension EditNameSheet {
    
    var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.white)
            .frame(width: 40, height: 5)
            .padding()
    }
    
    var title: some View {
        Text("What's your new name going to be?")
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .padding(.bottom, 40)
    }
    
    var newNameTextfield: some View {
        TextField("", text: $vm.editedName, prompt: Text("Type new name...").foregroundColor(Color.black))
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .foregroundColor(Color.black)
            .padding(.horizontal, 40)
            .frame(height: 40)
            .background(Color.white.opacity(1))
            .cornerRadius(10)
            .padding(.horizontal)
            .autocorrectionDisabled(true)
            .overlay(alignment: .trailing) {
                ZStack {
                    if !vm.editedName.isEmpty {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.red)
                            .opacity(vm.editedNameIsValid ? 0 : 1)
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .opacity(vm.editedNameIsValid ? 1 : 0)
                    }
                }
                .padding(.trailing, 30)
                .font(.system(.title2, weight: .semibold))
            }
    }
    
    var saveButton: some View {
        Button {
            if vm.editedName.count >= 2 && vm.editedName.count < 13 {
                onboardingVM.currentUserName = vm.editedName
                vm.showSheetForEditName = false
            }else {
                onboardingVM.alertForName = true
            }
            
        } label: {
            Text("SAVE")
                .foregroundColor(Color.black)
                .font(.system(.title, design: .rounded, weight: .medium))
                .frame(width: 310, height: 50)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom)
                .opacity(!vm.editedNameIsValid ? 0.5 : 1)
                .alert(isPresented: $onboardingVM.alertForName) {
                    Alert(title: Text("Wrong name"), message: Text("Your name must be min of 2 characters long and max of 12 short! 🙁"))
                }
        }
    }
    
}
