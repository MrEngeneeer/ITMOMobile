//
//  RefreshableViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Для обработки pull-to-refresh
protocol RefreshableViewController: AnyObject {
    func handlePullToRefresh()
}
