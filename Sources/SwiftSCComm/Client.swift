//
//  Client.swift
//  rdncat
//
//  Created by Harry on 6/7/22.
//

import Foundation
import Network

@available(iOS 12.0, *)
public class Client {
    public let connection: ClientConnection
    let host: NWEndpoint.Host
    let port: NWEndpoint.Port

    public init(host: String, port: UInt16) {
        self.host = NWEndpoint.Host(host)
        self.port = NWEndpoint.Port(rawValue: port)!
        let nwConnection = NWConnection(host: self.host, port: self.port, using: .tcp)
        connection = ClientConnection(nwConnection: nwConnection)
    }

    public func start() {
        print("Client started \(host) \(port)")
        connection.didStopCallback = didStopCallback(error:)
        connection.start()
    }

    public func stop() {
        connection.stop()
    }

    public func send(data: Data) {
        connection.send(data: data)
    }

    public func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
}

