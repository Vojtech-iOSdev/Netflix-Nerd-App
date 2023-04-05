//
//  OnboardingQuestion.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 04.04.2023.
//

import SwiftUI

struct OnboardingQuestion: View {
    
    let questionString: String
    
    var body: some View {
        Text(questionString)
            .foregroundColor(Color.white)
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
    }
}

struct OnboardingQuestion_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingQuestion(questionString: "What is your name?")
    }
}
