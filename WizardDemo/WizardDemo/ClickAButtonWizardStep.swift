//
//  ClickAButtonWizardStep.swift
//  WizardDemo
//
//  Created by Stefan Horner on 10/11/2025.
//

import SwiftUI
import YoureAWizardHarry

struct ClickAButtonWizardStep: View {
    @Environment(WizardState.self) var wizard
    @State var clicked: Bool = false

    var body: some View {
        Text("Click this button to be able to continue")
        Button(action: {
            clicked.toggle()
            wizard.stepIsValid = clicked
        }) {
            Text("Go on - click me")
        }
    }
}

#Preview {
    ClickAButtonWizardStep()
}
