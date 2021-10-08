import Foundation
import MultipeerConnectivity

class Session: MCSessionDelegate  {
    private let peerID: MCPeerID(displayName: UIDevice.current.name)
    private let serviceString: String
    private let session: MCSession?
    private let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser
    
    init(service: String) {
        serviceString = service
        session = MCSession(peer: peerID, securityIdentity: nil,
            encryptionPreference: .required)
        advertiser = MCNearbyServiceAdvertiser(peer: peerID
            discoveryInfo: nil, discoveryInfo: nil, serviceType: serviceString)

        super.init()
        session.delegate = self
        advertiser.delegate = self
    }


    // start advertising device and browsing for other devices
    func startDiscovery() {
        mcAdvertiser.startAdvertisingPeer()
        mcBrowser.startBrowsingForPeers()
    }

    // suspend advertising and browsing
    func suspendDiscovery() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser.stopBrowsingForPeers()
    }

    // suspend advertising and browsing and disconnect from session
    func stopDiscovery() {
        suspend()
        mcSession.disconnect()
    }

    // send data to all peers in the local network
    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        do {
            try mcSession.send(data, toPeers: peers, with: mode)
        } catch let error {
            NSLog("Error sending data: \(error)")
        }
    }
    
    // send data to specific peer in the local network
    func sendDataToPeer() {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
    }
}