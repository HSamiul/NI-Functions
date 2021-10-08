import Foundation
import MultipeerConnectivity

class Session: MCSessionDelegate  {
    private let peerID: MCPeerID(displayName: UIDevice.current.name)
    private let serviceString: String
    private let session: MCSession?
    private let advertiser: MCAdvertiserAssistant
    private let browser: MCNearbyServiceBrowser
    
    init(service: String) {
        serviceString = service
        session = MCSession(peer: peerID, securityIdentity: nil,
            encryptionPreference: .required)
        advertiser = MCAdvertiserAssistant(serviceType: service,
            discoveryInfo: nil, session: session)

        super.init()
        session.delegate = self
        advertiser.delegate = self
    }
}

// start advertising device and browsing for other devices
func startDiscovery() {

}

// suspend advertising and browsing
func suspendDiscovery() {

}

// suspend advertising and browsing and disconnect from session
func stopDiscovery() {

}

// send data to specific peer in the local network
func sendDataToPeer() {

}

// send data to all peers in the local network
func sendDataToAll() {

}
