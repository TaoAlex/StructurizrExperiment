workspace "Name" "Description" {

    !identifiers hierarchical

    model {
        customer = person "Renter"
        admin = person "Administrator"
        carRentalSystem = softwareSystem "Car Rental System" {
            rentalWebApp = container "Rental Web Application"
            db = container "Car Rental Database" {
                tags "Database"
            }
            adminwebapp = container "Admin Web Application"

            adminwebapp -> db "Add car"
            adminwebapp -> db "Remove car"
            rentalWebApp -> db "Update car"
        }

        customer -> carRentalSystem "Rents car"
        customer -> carRentalSystem "Returns car"
        admin -> carRentalSystem "Services car"
        admin -> carRentalSystem "Adds new car"
    }

    views {
        systemContext carRentalSystem "Diagram1" {
            include *
        }

        container carRentalSystem "Diagram2" {
            include *
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

    configuration {
        scope softwaresystem
    }

}
