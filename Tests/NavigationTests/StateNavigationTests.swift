import SwiftUI
import Testing

@testable import YoureAWizardHarry

var testState: WizardState {
    .init(
        nodes: [
            .init(
                title: "N1", image: Image(systemName: "car.ferry"),
                steps: [
                    .init(title: "N1S1") { Text("") },
                    .init(title: "N1S2") { Text("") },
                    .init(title: "N1S3") { Text("") },
                ]),
            .init(
                title: "N2", image: Image(systemName: "car.rear.waves.up"),
                steps: [
                    .init(title: "N2S1") { Text("") },
                    .init(title: "N2S2") { Text("") },
                    .init(title: "N2S3") { Text("") },
                ]),
        ], location: .initial())
}

@Test func `basic state accessors for initial location`() async throws {
    let state = testState

    #expect(state.isOnFirstStep == true, "State should initialise on first step")
    #expect(state.canContinue == true, "State should be able to continue")
    #expect(state.isComplete == false, "State should not be completed")

    #expect(state.current != nil, "Current should be retrievable")

    let (node, step, location) = state.current!
    #expect(location.node == 0 && location.step == 0, "Current location should be 0-0")
    #expect(node.title == "N1", "Current node should be N1")
    #expect(step.title == "N1S1", "Current step should be N1S1")
}

@Test func `basic state next/previous`() async throws {
    let state = testState

    #expect(state.location.asString == "0:0", "Should start on initial")
    #expect(state.next().location.asString == "0:1", "Should advance to 0:1")
    #expect(state.next().location.asString == "0:2", "Should advance to 0:2")
    #expect(state.next().location.asString == "1:0", "Should advance to 1:0")
    #expect(state.next().location.asString == "1:1", "Should advance to 1:1")
    #expect(state.next().location.asString == "1:2", "Should advance to 1:2")
    #expect(state.next().location.asString == "2:0", "Should advance to 2:0 - ie. conclusion")
    #expect(state.previous().location.asString == "1:2", "Should un-advance to 1:2")
    #expect(state.previous().location.asString == "1:1", "Should un-advance to 1:1")
    #expect(state.previous().location.asString == "1:0", "Should un-advance to 1:0")
    #expect(state.previous().location.asString == "0:2", "Should un-advance to 0:2")
    #expect(state.previous().location.asString == "0:1", "Should un-advance to 0:1")
    #expect(state.previous().location.asString == "0:0", "Should un-advance to 0:0")
}
