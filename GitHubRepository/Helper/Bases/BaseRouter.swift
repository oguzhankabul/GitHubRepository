//
//  BaseRouter.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import UIKit

protocol RouterProtocol {
    
    associatedtype V: UIViewController
    var viewController: V? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
}

class Router: RouterProtocol {
    
    weak var viewController: UIViewController?
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }
    
    func close(animated: Bool = true, completion: VoidClosure? = nil) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        if let openModalTransition = openTransition as? ModalTransition {
            openModalTransition.isAnimated = animated
            openModalTransition.completionHandler = completion
        }
        
        if let openPushTransition = openTransition as? PushTransition {
            openPushTransition.isAnimated = animated
            openPushTransition.completionHandler = completion
        }
        
        openTransition.close(viewController)
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
}
