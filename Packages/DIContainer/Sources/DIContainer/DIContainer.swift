public class DIContainer {

    // MARK: - Properties
    public static let `default` = DIContainer()
    private var registers = [ObjectIdentifier: () -> Any]()

    // MARK: - Methods
    public func register<S, R>(_ service: S.Type, maker: @escaping () -> R) {
        registers[ObjectIdentifier(service)] = maker
    }

    public func make<S, R>(for service: S.Type) -> R {
        let id = ObjectIdentifier(service)
        guard let maker = registers[id] else {
            fatalError(
                Localizable.serviceWasntPreviouslyRegistered(
                    .init(describing: service)
                ).localized
            )
        }
        guard let casted = maker() as? R else {
            fatalError(
                Localizable.serviceCantBeDowncasted(
                    String(describing: service),
                    .init(describing: R.self)
                ).localized)
        }
        return casted
    }
}

// MARK: - Util extensions
public extension DIContainer {
    static func register<S, R>(_ service: S.Type, maker: @escaping () -> R) {
        DIContainer.default.register(service, maker: maker)
    }

    static func make<S, R>(for service: S.Type) -> R {
        return DIContainer.default.make(for: service)
    }
}
