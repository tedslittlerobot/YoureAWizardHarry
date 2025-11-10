import SwiftUI

struct UIProgressBarNodeView: View {
    let index: Int
    let node: WizardState.Node
    @Binding var state: WizardState

    var status: Status {
        if state.location.node == index {
            .active
        } else {
            state.location.node > index ? .completed : .pending
        }
    }

    var stepIndex: Double {
        switch status {
            case .pending:
                0.0
            case .active:
                Double(state.location.step)
            case .completed:
                Double(node.steps.count)
        }
    }

    var body: some View {
        ZStack {
            Gauge(
                value: stepIndex,
                in: 0.0...Double(node.steps.count)
            ) {} currentValueLabel: {} minimumValueLabel: {
                Text("\(stepIndex.rounded() + 1)")
            } maximumValueLabel: {
                Text("\(node.steps.count)")
            }
            .tint(status.background)
            .gaugeStyle(.accessoryCircularCapacity)
            .rotationEffect(Angle(degrees: 180))

            node.image
                .frame(width: 30, height: 30)
                .foregroundStyle(status.foreground)
                .padding(5)
                .background(status.background)
                .overlay(
                    Circle().stroke(status.border, lineWidth: 3)
                )
                .clipShape(
                    Circle()
                )
        }
    }

    enum Status {
        case pending
        case active
        case completed

        var border: Color {
            switch self {
                case .pending:
                    .gray
                case .active:
                    .cyan
                case .completed:
                    Color.from(red: 3, green: 179, blue: 52)
            }
        }

        var foreground: Color {
            switch self {
                case .pending:
                    .gray
                case .active:
                    Color.from(red: 1, green: 55, blue: 248)
                case .completed:
                    .white
            }
        }

        var background: Color {
            switch self {
                case .pending:
                    Color.from(red: 234, green: 234, blue: 234)
                case .active:
                    Color.from(red: 50, green: 160, blue: 204)
                case .completed:
                    .green
            }
        }
    }
}

#Preview {
    VStack {
        HStack {
            UIProgressBarNodeView(
                index: 0,
                node: [WizardState.Node].forPreview[0],
                state: .constant(.forPreview),
            )

            UIProgressBarNodeView(
                index: 1,
                node: [WizardState.Node].forPreview[1],
                state: .constant(.forPreview.setLocation(node: 1, step: 1)),
            )

            UIProgressBarNodeView(
                index: 2,
                node: [WizardState.Node].forPreview[2],
                state: .constant(.forPreview),
            )
        }.padding()

        HStack {
            UIProgressBarNodeView(
                index: 0,
                node: [WizardState.Node].forPreview[0],
                state: .constant(.forPreview),
            )

            UIProgressBarNodeView(
                index: 0,
                node: [WizardState.Node].forPreview[1],
                state: .constant(.forPreview),
            )

            UIProgressBarNodeView(
                index: 0,
                node: [WizardState.Node].forPreview[2],
                state: .constant(.forPreview),
            )
        }
        .padding()
        .background(.black)
    }
}

