import Foundation
import MultipeerConnectivity

class Session: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate  {
    private let peerID = MCPeerID(displayName: UIDevice.current.name)
    private let serviceString: String
    private let session: MCSession
    private let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser
    
    init(service: String) {
        serviceString = service
        session = MCSession(peer: peerID, securityIdentity: nil,
            encryptionPreference: .required)
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID,
            discoveryInfo: nil, serviceType: serviceString)

        super.init()
        session.delegate = self
        nearbyServiceAdvertiser.delegate = self
    }


    // start advertising device and browsing for other devices
    func startDiscovery() {
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }

    // suspend advertising and browsing
    func suspendDiscovery() {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
    }

    // suspend advertising and browsing and disconnect from session
    func stopDiscovery() {
        suspendDiscovery()
        session.disconnect()
    }

    // send data to a specific peer
    func sendDataToPeer(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        do {
            try session.send(data, toPeers: peers, with: mode)
        } catch let error {
            NSLog("Error sending data: \(error)")
        }
    }
    
    // send data to all peers
    func sendDataToAllPeers(data: Data) {
        sendDataToPeer(data: data, peers: session.connectedPeers, mode: .reliable)
    }
}
