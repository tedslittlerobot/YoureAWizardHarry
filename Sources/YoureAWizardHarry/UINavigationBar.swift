import SwiftUI

struct UINavigationBar: View {
    @Environment(WizardState.self) var wizard

    var body: some View {
        HStack {
            Button(action: {
                wizard.previous()
            }) {
                Text("Back")
            }
            .disabled(wizard.isOnFirstStep)
            Spacer()
            Button(action: {
                wizard.next()
            }) {
                Text("Continue")
            }
            .buttonStyle(.glassProminent)
            .padding()
            .disabled(!wizard.canContinue)
        }
    }
}

#Preview {
    UINavigationBar()
}
