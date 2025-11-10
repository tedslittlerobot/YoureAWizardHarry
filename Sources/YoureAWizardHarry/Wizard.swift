import SwiftUI
import ConfettiSwiftUI

public struct Wizard: View {
    @State var state: WizardState
    @ViewBuilder let finishedContent: () -> any View

    public init(state: WizardState, @ViewBuilder finishedContent: @escaping () -> any View) {
        self.state = state
        self.finishedContent = finishedContent
    }

    public init(_ nodes: [WizardState.Node], @ViewBuilder finishedContent: @escaping () -> any View) {
        self.state = WizardState(nodes: nodes, location: .initial())
        self.finishedContent = finishedContent
    }

    public var body: some View {
        VStack {
            UIProgressBar(state: $state)
                .padding([.horizontal, .top])

            if !state.isComplete, let (node, step, _) = state.current {
                HStack {
                    Text(node.title).font(.title).fontWeight(.medium)
                    Text(step.title).font(.title).italic().fontWeight(.thin)
                    Spacer()
                }.padding([.horizontal])
            }
            Divider().frame(maxHeight: 2).background(Color.accentColor.opacity(0.6))
            Spacer()

            ScrollView {
                if state.isComplete {
                    AnyView(finishedContent()).padding()
                } else if let (_, step, _) = state.current {
                    AnyView(step.content()).padding()
                }
            }.confettiCannon(trigger: $state.completionCount, num: 100, openingAngle: .degrees(15), closingAngle: .degrees(165), radius: 500)
            Spacer()

            Divider().frame(maxHeight: 2).background(Color.accentColor.opacity(0.6))

            UINavigationBar()
                .padding([.horizontal])
                .padding([.bottom], 5)
        }.environment(state)
    }
}

#Preview {
    VStack {
        Text("hello")
    }.frame(width: 300, height: 300).padding()
}
