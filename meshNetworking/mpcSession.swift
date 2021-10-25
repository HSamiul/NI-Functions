//
//  MPCSession.swift
//  MPCSession-Example
//
//  Created by Samiul Hoque on 10/8/21.
//

import Foundation
import MultipeerConnectivity

class Session: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate  {
    private let peerID = MCPeerID(displayName: UIDevice.current.name) /* this device's name. "Sam's iPhone" */
    private let serviceString: String /* The service this session is providing */
    private let session: MCSession /* Session object to handle the technical stuff */
    private let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser /* The advertisement, visualized as a popup, for your service */
    private let nearbyServiceBrowser: MCNearbyServiceBrowser /* Searches for other devices to invite to your serivce */
    
    var peerDataHandler: ((Data, MCPeerID) -> Void)?
    
    /* internal means any file within the same module as this file can acccess this function */
    /* MCSessionDelegate protocol requires all these session functions to be implemented, even if we don't use all of them */

    internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let handler = peerDataHandler { /* if peerDataHandler isn't nil, then handle the data*/
            DispatchQueue.main.async {
                handler(data, peerID)
            }
        }
    }
    
    internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {

    }
    
    internal func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    internal func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation.
    }
    

    internal func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
    
    /* MCNearbyServiceBrowserDelegate protocol requires all these browser functions to be implemented */
    /* Look for a peer to invite to the session! */
    internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    }
    
    init(service: String) {
        serviceString = service
        session = MCSession(peer: peerID, securityIdentity: nil,
            encryptionPreference: .required)
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID,
            discoveryInfo: nil, serviceType: serviceString)
        nearbyServiceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceString)

        super.init()
        session.delegate = self
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceBrowser.delegate = self
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
