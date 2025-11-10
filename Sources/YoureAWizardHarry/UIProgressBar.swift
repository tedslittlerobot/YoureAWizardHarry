import SwiftUI

struct UIProgressBar: View {
    @Binding var state: WizardState

    var body: some View {
        HStack {
            ForEach(state.nodes.enumerated(), id: \.offset) { index, node in
                UIProgressBarNodeView(
                    index: index,
                    node: node,
                    state: $state,
                )

                if node != state.nodes.last {
                    Rectangle()
                        .frame(maxWidth: 50, minHeight: 2, maxHeight: 2).background(.gray)
                }
            }
        }
    }
}

#Preview {
    VStack {
        VStack {
            UIProgressBar(
                state: .constant(.forPreview),
            )

            UIProgressBar(
                state: .constant(.forPreview.setLocation(node: 1, step: 1)),
            )

            UIProgressBar(
                state: .constant(.forPreview.setLocation(node: 2, step: 2)),
            )

        }.frame(width: 300, height: 200).padding()
        VStack {
            UIProgressBar(
                state: .constant(.forPreview),
            )

            UIProgressBar(
                state: .constant(.forPreview.setLocation(node: 1, step: 1)),
            )

            UIProgressBar(
                state: .constant(.forPreview.setLocation(node: 2, step: 2)),
            )

        }.frame(width: 300, height: 200).padding()
            .background(.black)
    }
}
