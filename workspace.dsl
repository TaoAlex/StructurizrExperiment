workspace "Name" "Description" {

    !identifiers hierarchical

    model {
        customer = person "Renter"
        rentalAdmin = person "Rental administrator"
        carMechanic = person "Car mechanic"
        carRentalSystem = softwareSystem "Car Rental System" {
            rentalWebApp = container "Rental Web Application"
            db = container "Car Rental Database" {
                tags "Database"
            }
            adminwebapp = container "Admin Web Application"
            authenticationAdapter = container "Authentication adapter"
            authorizationAdapter = container "Authorization adapter"
            carLocationAdapter = container "Car location adapter"
            invoicingAdapter = container "Invoicing adapter"
            paymentAdapter = container "Payment adapter"

            adminwebapp -> db "Add car"
            adminwebapp -> db "Remove car"
            rentalWebApp -> db "Update car"
            rentalWebApp -> invoicingAdapter "Create invoice"
            rentalWebApp -> invoicingAdapter "Send invoice"
            rentalWebApp -> invoicingAdapter "Cancel invoice"
            rentalWebApp -> authenticationAdapter "Authenticate"
            rentalWebApp -> authenticationAdapter "Authorize"
            rentalWebApp -> paymentAdapter "Send payment"
            rentalWebApp -> carLocationAdapter "Get cars by location"
        }
        carLocationSystem = softwareSystem "Car Location System" {
            api = container "Front-end api"
            locationManager = container "Location manager"
            db = container "Database" {
                tags "Database"
            }
            gpsService = container "GPS Service"

            api -> locationManager "Find cars by location"
            locationManager -> gpsService "Check cars in proximity to coordinate"
        }
        carMaintenanceSystem = softwareSystem "Car Maintenance System" {
            carMaintenanceManager = container "Manager"
            db = container "Car maintenance database"
            incidentReportReceiver = container "Incident report receiver"
            carMaintenanceScheduler = container "Car maintenance scheduler"
            carMaintainanceCompletetionReportReceiver = container "Car maintenance completion report receiver"

            carMaintenanceManager -> carMaintenanceScheduler "Schedule car for maintenance"
            carMaintenanceManager -> carMaintenanceScheduler "Deschedule car maintenance"
            incidentReportReceiver -> carMaintenanceManager "Notify of car incident"
            carMaintainanceCompletetionReportReceiver -> carMaintenanceManager "Car maintenance completion report"
            carMaintenanceScheduler -> db "Add schedule"
            carMaintenanceScheduler -> db "Remove schedule"
            carMaintenanceManager -> db "Add incident"
            carMaintenanceManager -> db "Remove incident"
            
        }
        authenticationSoftware = softwareSystem "Authentication System" {
            api = container "Front-end api"
            db = container "Users Database" {
                tags "Database"
            }
            authenticator = container "Authentication Manager"
            encryptor = container "Encryption Service"
            decryptor = container "Decryption Service"

            api -> authenticator "Authenticate user"
            authenticator -> db "Retrieve user"
            authenticator -> encryptor "Encrypt password"
            authenticator -> decryptor "Decrypt password"
        }
        authorizationSoftware = softwareSystem "Authorization System" {
            authorizationApi = container "Authorization Front-end api"
            userRoleManagementApi = container "User role management Front-end api"
            db = container "User roles Database" {
                tags "Database"
            }
            authorizationService = container "Authorizer"
            userRoleManager = container "User role manager"

            authorizationApi -> authorizationService "Check user authorization"
            userRoleManagementApi -> userRoleManager "Add role to user"
            userRoleManagementApi -> userRoleManager "Remove role from user"
            userRoleManager -> db "Add role"
            userRoleManager -> db "Add user role"
            userRoleManager -> db "remove user role"
            authorizationService -> db "Get user role"
        }
        invoicingSystem = softwareSystem "Invoicing System" {
            api = container "Front-end api"
            db = container "Invoicing database" {
                tags "Database"
            }
            sender = container "Invoice sender" {
                email = component "Email sender"
                post = component "Post sender"
                SMS = component "SMS sender"
            }
            builder = container "Invoice builder"

            api -> builder "Generate invoice"
            api -> sender "Send invoice"
            builder -> db "Add invoice"
            sender -> db "Update invoice"
            sender -> db "Remove invoice"
        }
        paymentSystem = softwareSystem "Payment System" {
            api = container "Front-end api"
        }


        customer -> carRentalSystem.rentalWebApp "Rents car"
        customer -> carRentalSystem.rentalWebApp "Returns car"
        rentalAdmin -> carRentalSystem.adminwebapp "Services car"
        rentalAdmin -> carRentalSystem "Adds new car"
        carRentalSystem.paymentAdapter -> paymentSystem.api "Pay for rental"
        carRentalSystem.invoicingAdapter -> invoicingSystem.api "Generate invoice for rental"
        carRentalSystem.carLocationAdapter -> carLocationSystem.api "Get car location"
        carRentalSystem.carLocationAdapter -> carLocationSystem.api "Get all cars in location"
        carRentalSystem.authorizationAdapter -> authorizationSoftware.authorizationApi "Authorize user"
        carRentalSystem.authenticationAdapter -> authenticationSoftware.api "Authenticate user"
    }

    views {
        systemContext carRentalSystem "CarRentalSystemContext" {
            include *
            autolayout lr
        }

        container all {
            include *
            autolayout lr
        }
        
        container invoicingSystem "InvoicingSystem" {
            include *
            autolayout lr
        }
        
        container paymentSystem "PaymentSystem" {
            include *
            autolayout lr
        }
        
        container authorizationSoftware "AuthorizationSystem" {
            include *
            autolayout lr
        }
        
        container authenticationSoftware "AuthenticationSystem" {
            include *
            autolayout lr
        }
        
        container carMaintenanceSystem "CarManitenanceSystem" {
            include *
            autolayout lr
        }
        
        container carLocationSystem "CarLocationSystem" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #ffffff
            }
            element "Renter" {
                background #199b65
                shape person
            }
            element "Car Rental System" {
                background #1eba79
            }
            element "Container" {
                background #23d98d
            }
            element "Car Rental Database" {
                shape cylinder
            }
        }
    }

    # configuration {
    #     scope softwaresystem
    # }

}
