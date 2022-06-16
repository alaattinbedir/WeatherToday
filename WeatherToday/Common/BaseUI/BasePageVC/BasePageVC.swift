//
//  BasePageVC.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import UIKit

class BasePageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    private(set) var orderedViewControllers: [UIViewController] = []
    var selectedChildIndex = 0
    var willBeSelected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        setViewControllers([orderedViewControllers[selectedChildIndex]],
                           direction: .forward,
                           animated: false,
                           completion: nil)

        for view in view.subviews {
            guard let view = view as? UIScrollView else { continue }
            view.delegate = self
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(pageChildren: [UIViewController], selectedIndex: Int) {
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll,
                   navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
                   options: nil)
        orderedViewControllers = pageChildren
        selectedChildIndex = selectedIndex
    }

    func setViewModelData(data: ViewModelData?, at index: Int) {
        guard index < orderedViewControllers.count else { return }
        if let viewController = orderedViewControllers[index] as? BaseDataViewController {
            viewController.data = data
        }
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if SessionKeeper.shared.selectedTabIndex != 0 {
            for view in view.subviews {
                guard let view = view as? UIScrollView else { continue }
                view.isScrollEnabled = false
            }
            return nil
        } else {
            for view in view.subviews {
                guard let view = view as? UIScrollView else { continue }
                view.isScrollEnabled = true
            }
        }

        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if SessionKeeper.shared.selectedTabIndex != 0 {
            for view in view.subviews {
                guard let view = view as? UIScrollView else { continue }
                view.isScrollEnabled = false
            }
            return nil
        } else {
            for view in view.subviews {
                guard let view = view as? UIScrollView else { continue }
                view.isScrollEnabled = true
            }
        }

        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        if orderedViewControllersCount <= nextIndex {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }

    func pageViewController(_: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let page = pendingViewControllers.first else { return }
        willBeSelected = orderedViewControllers.firstIndex(of: page) ?? 0
    }
}
