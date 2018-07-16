import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())
    
    let transportConfig = MySQLTransportConfig.unverifiedTLS
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "172.20.0.248",
        port: 3306,
        username: "3DzyCwM6cIP2QJ8@10.0.10.71",
        password: "root",
        database: "3DzyCwM6cIP2QJ8",
        transport: transportConfig
    )
    services.register(mysqlConfig)

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Patient.self, database: .mysql)
    services.register(migrations)

}
