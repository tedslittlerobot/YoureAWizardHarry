//
//  ContentView.swift
//  WizardDemo
//
//  Created by Stefan Horner on 10/11/2025.
//

import SwiftUI
import YoureAWizardHarry

struct ContentView: View {
    var body: some View {
        Wizard([
            WizardState.Node(title: "Introduction", image: Image(systemName: "info"), steps: [
                WizardState.Step(title: "Welcome") {
                    Text("Welcome to the wizard")
                    Text("Press continue to... continue...")
                },
                WizardState.Step(title: "Welcome") {
                    Text("Keep continuing - you will be taken through two more phases")
                },
            ]),
            WizardState.Node(title: "Phase One", image: Image(systemName: "car.ferry"), steps: [
                WizardState.Step(title: "Step One") {
                    Text("This is the first step of the first phase")
                },
                WizardState.Step(title: "Step Two") {
                    Text("This is the second step of the first phase")
                },
                WizardState.Step(title: "Step One") {
                    Text("This is the third step of the first phase")
                },
            ]),
            WizardState.Node(title: "Phase Two", image: Image(systemName: "car.rear.waves.up"), steps: [
                WizardState.Step(title: "Step One", withValidation: true) { ClickAButtonWizardStep().id("2-1") },
                WizardState.Step(title: "Step Two", withValidation: true) { ClickAButtonWizardStep().id("2-2") },
                WizardState.Step(title: "Final Step", withValidation: true) { ClickAButtonWizardStep().id("2-3") },
            ]),
        ]) {
            Text("Well done, you have finished the Wizard!")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
