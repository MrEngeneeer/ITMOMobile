//
//  LifecycleAwareViewController.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 27.03.2025.
//

// Для синхронизации с AppDelegate
protocol LifecycleAwareViewController: AnyObject {
    func viewWillBecomeActive()
    func viewWillResignActive()
}
