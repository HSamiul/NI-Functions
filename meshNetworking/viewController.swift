//
//  ContentView.swift
//  MPCSession-Example
//
//  Created by Samiul Hoque on 10/8/21.
//

/* Sample view controller displaying basic mpc session info */

import SwiftUI
import MultipeerConnectivity

let mpc: Session = Session(service: "test-run")

struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Service: " + mpc.getServiceString())
                Text("Your peerID:")
                    .padding()

            }
            VStack {
                Text("Peer peer's peerID:")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
