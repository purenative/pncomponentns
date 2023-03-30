import UIKit
import SwiftUI

public class PagingViewBaseController<Page: View>: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    typealias OnPageIndexChanged = (Int) -> Void
    
    private var hostingControllers: [UIViewController] = []
    
    var looped: Bool = false
    var onPageIndexChanged: OnPageIndexChanged?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
    }
    
    func setPages(_ pages: [Page]) {
        hostingControllers = pages.map { page in
            UIHostingController(rootView: page)
        }
        
        if let viewControllerToShow = hostingControllers.first {
            setViewControllers(
                [viewControllerToShow],
                direction: .forward,
                animated: true
            )
        } else {
            setViewControllers(
                [],
                direction: .forward,
                animated: true
            )
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let count = hostingControllers.count

        guard count > 0, let currentIndex = hostingControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1 
        
        if nextIndex < count {
            return hostingControllers[nextIndex]
        } else {
            return looped ? hostingControllers.first : nil
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let count = hostingControllers.count
        
        guard count > 0, let currentIndex = hostingControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        if previousIndex >= 0 {
            return hostingControllers[previousIndex]
        } else {
            return looped ? hostingControllers.last : nil
        }
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = hostingControllers.firstIndex(of: visibleViewController) {
            onPageIndexChanged?(index)
        }
    }
    
}
