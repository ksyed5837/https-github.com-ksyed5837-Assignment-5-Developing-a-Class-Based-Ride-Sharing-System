#include <iostream>
#include <iomanip>
#include <memory>
#include <string>
#include <vector>

// ===== Ride (Base Class) =====
class Ride {
private:
    int rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance; // miles

public:
    Ride(int id, std::string pickup, std::string dropoff, double miles)
        : rideID(id), pickupLocation(std::move(pickup)),
          dropoffLocation(std::move(dropoff)), distance(miles) {}

    virtual ~Ride() = default;

    double getDistance() const { return distance; }
    int getRideID() const { return rideID; }

    // Polymorphic behavior
    virtual double fare() const {
        // Base fare: $2.00 + $1.50 per mile
        return 2.0 + (1.5 * distance);
    }

    virtual void rideDetails() const {
        std::cout << "Ride " << rideID << " | "
                  << pickupLocation << " -> " << dropoffLocation
                  << " | " << distance << " miles";
    }
};

// ===== StandardRide =====
class StandardRide : public Ride {
public:
    using Ride::Ride; // reuse constructor
    double fare() const override {
        // Standard: $2.00 + $1.50 per mile
        return 2.0 + (1.5 * getDistance());
    }
};

// ===== PremiumRide =====
class PremiumRide : public Ride {
public:
    using Ride::Ride; // reuse constructor
    double fare() const override {
        // Premium: $5.00 + $3.00 per mile
        return 5.0 + (3.0 * getDistance());
    }
};

// ===== Driver =====
class Driver {
private:
    int driverID;
    std::string name;
    double rating;
    std::vector<std::unique_ptr<Ride>> assignedRides; // encapsulated

public:
    Driver(int id, std::string n, double r) : driverID(id), name(std::move(n)), rating(r) {}

    // Encapsulation: assignedRides is private; add via method only
    void addRide(std::unique_ptr<Ride> ride) {
        assignedRides.push_back(std::move(ride));
    }

    void getDriverInfo() const {
        std::cout << "Driver " << name << " (Rating: " << rating
                  << ") | Completed Rides: " << assignedRides.size() << "\n";
    }
};

// ===== Rider =====
class Rider {
private:
    int riderID;
    std::string name;
    std::vector<std::string> requestedRides; // store ride summaries

public:
    Rider(int id, std::string n) : riderID(id), name(std::move(n)) {}

    void requestRide(const Ride& ride) {
        requestedRides.push_back("Requested Ride " + std::to_string(ride.getRideID()));
    }

    void viewRides() const {
        std::cout << "Rider " << name << " Ride History:\n";
        for (const auto& s : requestedRides) {
            std::cout << "  - " << s << "\n";
        }
    }
};

// ===== Demo / Sample Run =====
int main() {
    std::cout << std::fixed << std::setprecision(2);

    // Polymorphism: store different ride types together
    std::vector<std::unique_ptr<Ride>> rides;
    rides.push_back(std::make_unique<StandardRide>(101, "Downtown", "Airport", 12.0));
    rides.push_back(std::make_unique<PremiumRide>(102, "Mall", "Hotel", 5.0));

    std::cout << "Ride List (Polymorphic fare calls):\n";
    for (const auto& r : rides) {
        r->rideDetails();
        std::cout << " | Fare: $" << r->fare() << "\n";
    }

    // Driver and Rider
    Driver driver(1, "Aisha", 4.9);
    Rider rider(10, "Kashif");

    // Assign rides to driver (move ownership) + record rider history
    for (auto& r : rides) {
        rider.requestRide(*r);
        driver.addRide(std::move(r));
    }
    rides.clear();

    std::cout << "\n";
    driver.getDriverInfo();
    std::cout << "\n";
    rider.viewRides();

    return 0;
}
