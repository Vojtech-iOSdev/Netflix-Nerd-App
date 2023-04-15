//
//  EditAgeSheet.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 01.04.2023.
//

import SwiftUI

struct EditAgeSheet: View {
    
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @StateObject var vm: ProfileViewModel = ProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            whiteRectangle
            
            Spacer()
            
            title
            newAgeSliderAndText
            
            Spacer()
            
            saveButton
        }
        .presentationDetents([.fraction(0.7)])
        .presentationDragIndicator(.hidden)
    }
}

struct EditAgeSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditAgeSheet()
    }
}

private extension EditAgeSheet {
    var whiteRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.white)
            .frame(width: 40, height: 5)
            .padding()
    }
    
    var title: some View {
        Text("Did you got older by any chance? 🤣")
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .padding(.bottom, 40)
    }
    
    var newAgeSliderAndText: some View {
        VStack {
            Text("Your age is: \(String(format: "%.0f", vm.editedAge))")
                .foregroundColor(Color.white)
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            Slider(value: $vm.editedAge,
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
            .padding(.horizontal)
        }
    }
    
    var saveButton: some View {
        Button {
            onboardingVM.currentUserAge = Int(vm.editedAge)
            dismiss()

        } label: {
            Text("SAVE")
                .foregroundColor(Color.black)
                .font(.system(.title, design: .rounded, weight: .medium))
                .frame(width: 310, height: 50)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom)
        }
    }
    
}
