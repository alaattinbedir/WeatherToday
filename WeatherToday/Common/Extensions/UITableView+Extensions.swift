//
//  UITableView+Extensions.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import Foundation

extension UITableView {
    typealias Complition = () -> Void
    typealias HeaderFooterTuple = (header: UIView?, footer: UIView?)
    typealias VisibleHeaderFooter = [Int: HeaderFooterTuple]

    enum AnimationType {
        case simple(duration: TimeInterval,
                    direction: Direction,
                    constantDelay: TimeInterval)
        case spring(duration: TimeInterval,
                    damping: CGFloat,
                    velocity: CGFloat,
                    direction: Direction,
                    constantDelay: TimeInterval)

        func animate(tableView: UITableView, reversed: Bool = false, completion: Complition? = nil) {
            var duration: TimeInterval = 0.0
            var damping: CGFloat = 1
            var velocity: CGFloat = 0
            var constantDelay: TimeInterval = 0.0
            var direction: Direction = .left(useCellsFrame: true)

            switch self {
            case let .simple(aDuration, aDirection, aConstantDelay):
                duration = aDuration
                direction = aDirection
                constantDelay = aConstantDelay
            case let .spring(aDuration, aDamping, aVelocity, aDirection, aConstantDelay):
                duration = aDuration
                damping = aDamping
                velocity = aVelocity
                direction = aDirection
                constantDelay = aConstantDelay
            }

            _ = tableView.visibleCells
            let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows
            let grouped = (indexPathsForVisibleRows?.grouped { $0.section }.sorted { $0.key < $1.key })~

            let visibleHeaderFooter = tableView.visibleSectionIndexes()
            var visibleViews = [UIView]()

            for items in grouped {
                var currentViews: [UIView] = items.value.compactMap { tableView.cellForRow(at: $0) }
                if let header = visibleHeaderFooter[items.key]?.header {
                    currentViews.insert(header, at: 0)
                }
                if let footer = visibleHeaderFooter[items.key]?.footer {
                    currentViews.append(footer)
                }
                visibleViews += currentViews
            }
            let visibleCellsCount = Double(visibleViews.count)
            let cells = direction.reverse(for: reversed ? visibleViews.reversed() : visibleViews)
            cells.enumerated().forEach { item in
                let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) +
                    Double(item.offset) * constantDelay
                direction.startValues(tableView: tableView, for: item.element)
                let anchor = item.element.layer.anchorPoint
                UIView.animate(
                    withDuration: duration,
                    delay: delay,
                    usingSpringWithDamping: damping,
                    initialSpringVelocity: velocity,
                    options: .curveEaseInOut,
                    animations: {
                        direction.endValues(tableView: tableView, for: item.element)
                    }, completion: { _ in
                        item.element.layer.anchorPoint = anchor
                        completion?()
                    }
                )
            }
        }
    }

    enum Direction {
        case left(useCellsFrame: Bool)
        case top(useCellsFrame: Bool)
        case right(useCellsFrame: Bool)
        case bottom(useCellsFrame: Bool)
        case rotation(angle: Double)
        case rotation3D(type: TransformType)

        // For testing only
        init?(rawValue: Int, useCellsFrame: Bool) {
            switch rawValue {
            case 0:
                self = Direction.left(useCellsFrame: useCellsFrame)
            case 1:
                self = Direction.top(useCellsFrame: useCellsFrame)
            case 2:
                self = Direction.right(useCellsFrame: useCellsFrame)
            case 3:
                self = Direction.bottom(useCellsFrame: useCellsFrame)
            case 4:
                self = Direction.rotation(angle: -Double.pi / 2)
            default:
                return nil
            }
        }

        func startValues(tableView: UITableView, for cell: UIView) {
            cell.alpha = 0
            switch self {
            case let .left(useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case let .top(useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case let .right(useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case let .bottom(useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case let .rotation(angle):
                cell.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            case let .rotation3D(type):
                type.set(for: cell)
            }
        }

        func endValues(tableView: UITableView, for cell: UIView) {
            cell.alpha = 1
            switch self {
            case let .left(useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case let .top(useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case let .right(useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case let .bottom(useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case .rotation:
                cell.transform = .identity
            case .rotation3D:
                cell.layer.transform = CATransform3DIdentity
            }
        }

        func reverse(for cells: [UIView]) -> [UIView] {
            switch self {
            case .bottom:
                return cells.reversed()
            default:
                return cells
            }
        }

        enum TransformType {
            case ironMan
            case thor
            case spiderMan
            case captainMarvel
            case hulk
            case daredevil
            case deadpool
            case doctorStrange

            func set(for cell: UIView) {
                let oldFrame = cell.frame
                var transform = CATransform3DIdentity
                transform.m34 = 1.0 / -500

                switch self {
                case .ironMan:
                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
                case .thor:
                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 0, 1, 0)
                case .spiderMan:
                    cell.layer.anchorPoint = .zero
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 1)
                case .captainMarvel:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 1, 1)
                case .hulk:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 1, 1)
                case .daredevil:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
                case .deadpool:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 0, 1)
                case .doctorStrange:
                    cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 0, 0)
                }

                cell.frame = oldFrame
                cell.layer.transform = transform
            }
        }
    }

    func reloadData(with animation: AnimationType, reversed: Bool = false, completion: Complition? = nil) {
        reloadData()
        animation.animate(tableView: self, reversed: reversed, completion: completion)
    }
}

// swiftlint:enable all

extension UITableView {
    func visibleSectionIndexes() -> VisibleHeaderFooter {
        let visibleTableViewRect = CGRect(x: contentOffset.x,
                                          y: contentOffset.y,
                                          width: bounds.size.width,
                                          height: bounds.size.height)

        var visibleHeaderFooter: VisibleHeaderFooter = [:]
        (0 ..< numberOfSections).forEach {
            let headerRect = rectForHeader(inSection: $0)
            let footerRect = rectForFooter(inSection: $0)

            let header: UIView? = visibleTableViewRect.intersects(headerRect) ? headerView(forSection: $0) : nil
            let footer: UIView? = visibleTableViewRect.intersects(footerRect) ? footerView(forSection: $0) : nil

            let headerFooterTuple: HeaderFooterTuple = (header: header, footer: footer)
            visibleHeaderFooter[$0] = headerFooterTuple
        }

        return visibleHeaderFooter
    }

    func scrollToBottom() {
        guard numberOfSections > 0, numberOfRows(inSection: numberOfSections - 1) > 0 else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let indexPath = IndexPath(row: self.numberOfRows(inSection: self.numberOfSections - 1) - 1,
                                      section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        let name = String(describing: type).components(separatedBy: ".")[0]
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueCell<T: UITableViewCell>(_: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }
}
