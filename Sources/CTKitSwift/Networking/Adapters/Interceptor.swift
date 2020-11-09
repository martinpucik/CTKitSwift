//
//  Interceptor.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 09.11.2020.
//

import Foundation
import Combine

struct Interceptor: Publisher {

    typealias Failure = URLError
    typealias Output = URLRequest

    private var request: URLRequest
    private let adapters: [RequestAdapting]
    
    init(request: URLRequest, adapters: [RequestAdapting]) {
        self.request = request
        self.adapters = adapters
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        subscriber.receive(subscription: InterceptorSubscription(request: request, adapters: adapters, subscriber: subscriber))
    }
}

final class InterceptorSubscription<S: Subscriber>: Subscription where S.Input == URLRequest, S.Failure == URLError {
    
    private var request: URLRequest
    private var subscriber: S?
    private var adapters: [RequestAdapting]
    private var cancelBag: Set<AnyCancellable> = Set()
    
    init(request: URLRequest, adapters: [RequestAdapting], subscriber: S) {
        self.request = request
        self.subscriber = subscriber
        self.adapters = adapters
        adaptRequest()
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
    
    private func adaptRequest() {
        if let adapter = adapters.first {
            adapter.adapt(request).sink(receiveValue: { [weak self] newRequest in
                self?.adapters.removeFirst()
                self?.request = newRequest
                self?.adaptRequest()
            }).store(in: &cancelBag)
        } else {
            _ = subscriber?.receive(request)
            subscriber?.receive(completion: Subscribers.Completion<URLError>.finished)
        }
    }
}
