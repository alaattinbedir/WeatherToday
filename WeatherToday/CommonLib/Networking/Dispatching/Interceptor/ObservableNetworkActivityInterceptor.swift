//
//  ObservableNetworkActivityInterceptor.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public class ObservableNetworkActivityInterceptor: RequestInterceptor, ResponseInterceptor {
    private let observer: (_ interceptor: ObservableNetworkActivityInterceptor, _ activeNetworkCallCount: Int) -> Void
    @Atomic
    public var activeNetworkCallCount: Int

    public init(observer: @escaping (_ interceptor: ObservableNetworkActivityInterceptor,
                                     _ activeNetworkCallCount: Int) -> Void) {
        self.observer = observer
        activeNetworkCallCount = 0
    }

    public func onRequest(_ endpoint: Endpoint, _ request: URLRequest) -> URLRequest {
        if let observableNetworkActivity = endpoint as? ObservableNetworkActivity, observableNetworkActivity.lockScreen {
            activeNetworkCallCount += 1
            notify()
        }
        return request
    }

    public func onResponse(_ endpoint: Endpoint, _: URLRequest,
                           _ result: NetworkDispatchResult) -> NetworkDispatchResult {
        if let observableNetworkActivity = endpoint as? ObservableNetworkActivity, observableNetworkActivity.lockScreen {
            activeNetworkCallCount -= 1
            notify()
        }
        return result
    }

    private func notify() {
        observer(self, activeNetworkCallCount)
    }
}
