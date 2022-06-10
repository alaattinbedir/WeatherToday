//
//  NetworkResponseObserver.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 10.06.2022.
//

import Foundation

public class NetworkResponsePromise<SuccessType, ErrorType>: NetworkResponseFuture<SuccessType, ErrorType> {
    override public init() {
        super.init()
    }

    public func prepared(request: URLRequest) {
        state = .preparation(request)
    }

    public func started(task: URLSessionTask) {
        state = .start(task)
    }

    public func cancelled() {
        state = .cancel
    }

    public func failed(error: ErrorType) {
        state = .failure(error)
    }

    public func succeeded(success: SuccessType) {
        state = .success(success)
    }

    public func completed(success: SuccessType?, error: ErrorType?) {
        state = .completed(success, error)
    }
}

public class NetworkResponseFuture<SuccessType, ErrorType> {
    private let completeOnMainThread: Bool = true

    // swiftformat:disable redundantSelf
    fileprivate var state: NetworkResponseFutureState<SuccessType, ErrorType>? {
        didSet {
            switch state {
            case let .preparation(request):
                preparedCallBack?(request)
            case let .start(task):
                startedCallBack?(task)
            case let .success(response):
                complete(with: self.successCallBack?(response) ?? { /* Empty */ }())
            case let .failure(error):
                complete(with: self.errorCallBack?(error) ?? { /* Empty */ }())
            case .cancel:
                complete(with: self.cancelledCallBack?() ?? { /* Empty */ }())
            case let .completed(success, error):
                complete(with: self.completedCallBack?(success, error) ?? { /* Empty */ }())
            case .none:
                break
            }
        }
    }

    private var preparedCallBack: ((URLRequest) -> Void)?
    private var successCallBack: ((SuccessType) -> Void)?
    private var errorCallBack: ((ErrorType) -> Void)?
    private var cancelledCallBack: (() -> Void)?
    private var completedCallBack: ((SuccessType?, ErrorType?) -> Void)?
    private var startedCallBack: ((URLSessionTask) -> Void)?

    @discardableResult
    public func onSucceeded(_ callBack: @escaping ((SuccessType) -> Void)) -> Self {
        if let state = state, case let .success(success) = state {
            callBack(success)
        } else {
            successCallBack = callBack
        }
        return self
    }

    @discardableResult
    public func onError(_ callBack: @escaping ((ErrorType) -> Void)) -> Self {
        if let state = state, case let .failure(error) = state {
            callBack(error)
        } else {
            errorCallBack = callBack
        }

        return self
    }

    @discardableResult
    public func onCompleted(_ callBack: @escaping ((SuccessType?, ErrorType?) -> Void)) -> Self {
        if let state = state, case let .completed(success, error) = state {
            callBack(success, error)
        } else {
            completedCallBack = callBack
        }

        return self
    }

    @discardableResult
    public func onPrepared(_ callBack: @escaping ((URLRequest) -> Void)) -> Self {
        if let state = state, case let .preparation(request) = state {
            callBack(request)
        } else {
            preparedCallBack = callBack
        }
        return self
    }

    @discardableResult
    public func onStarted(_ callBack: @escaping ((URLSessionTask) -> Void)) -> Self {
        if let state = state, case let .start(task) = state {
            callBack(task)
        } else {
            startedCallBack = callBack
        }
        return self
    }

    @discardableResult
    public func onCancelled(_ callBack: @escaping (() -> Void)) -> Self {
        if let state = state, case .cancel = state {
            callBack()
        } else {
            cancelledCallBack = callBack
        }
        return self
    }

    private func complete(with callback: @autoclosure @escaping () -> Void) {
        let queue: DispatchQueue
        if completeOnMainThread {
            queue = DispatchQueue.main
        } else {
            queue = DispatchQueue.global()
        }

        queue.async { [weak self] in
            callback()
            self?.complete()
        }
    }

    func complete() {
        preparedCallBack = nil
        successCallBack = nil
        errorCallBack = nil
        cancelledCallBack = nil
        startedCallBack = nil
    }

    deinit {
        complete()
    }
}

private enum NetworkResponseFutureState<SuccessType, ErrorType> {
    case preparation(URLRequest)
    case start(URLSessionTask)
    case success(SuccessType)
    case failure(ErrorType)
    case completed(SuccessType?, ErrorType?)
    case cancel
}
