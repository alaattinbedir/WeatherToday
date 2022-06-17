//
//  UIPageViewController+Navigation.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import UIKit

extension UIPageViewController {
    func goToNextPage(animated: Bool = true) {
        if let currentViewController = viewControllers?[0],
           let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
            setViewControllers([nextPage], direction: .forward, animated: animated, completion: nil)
        }
    }

    func goToPreviousPage(animated: Bool = true) {
        if let currentViewController = viewControllers?[0],
           let nextPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
            setViewControllers([nextPage], direction: .reverse, animated: animated, completion: nil)
        }
    }
}
