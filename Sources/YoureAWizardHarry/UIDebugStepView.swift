import SwiftUI

public struct DebugWizardStepView: View {
    @Environment(WizardState.self) var wizard

    public init() {}

    public var body: some View {
        VStack {
            Text("This is a wizard step")

            Text("Node \(wizard.location.node + 1)")

            if let node = wizard.currentNode {
                Text("Step \(wizard.location.step + 1) / \(node.steps.count)")
            }
        }
    }
}

#Preview {
    DebugWizardStepView().environment(WizardState.forPreview)
}
