"===== Ride ====="
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    package: 'RideShare'.

Ride class >> id: anID pickup: p dropoff: d distance: miles
    ^ self new
        rideID: anID;
        pickupLocation: p;
        dropoffLocation: d;
        distance: miles;
        yourself.

Ride >> rideID: anID       rideID := anID.
Ride >> pickupLocation: p  pickupLocation := p.
Ride >> dropoffLocation: d dropoffLocation := d.
Ride >> distance: miles    distance := miles.

Ride >> distance
    ^ distance.

Ride >> fare
    "Base fare: $2.00 + $1.50 per mile"
    ^ 2.0 + (1.5 * self distance).

Ride >> rideDetails
    ^ String streamContents: [ :s |
        s
            nextPutAll: 'Ride '; nextPutAll: rideID asString; nextPutAll: ' | ';
            nextPutAll: pickupLocation; nextPutAll: ' -> '; nextPutAll: dropoffLocation; nextPutAll: ' | ';
            nextPutAll: distance asString; nextPutAll: ' miles' ].


"===== StandardRide ====="
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideShare'.

StandardRide >> fare
    "Standard: $2.00 + $1.50 per mile"
    ^ 2.0 + (1.5 * self distance).


"===== PremiumRide ====="
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideShare'.

PremiumRide >> fare
    "Premium: $5.00 + $3.00 per mile"
    ^ 5.0 + (3.0 * self distance).


"===== Driver ====="
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    package: 'RideShare'.

Driver class >> id: anID name: aName rating: aRating
    ^ self new
        driverID: anID;
        name: aName;
        rating: aRating;
        assignedRides: OrderedCollection new;
        yourself.

Driver >> driverID: anID  driverID := anID.
Driver >> name: aName     name := aName.
Driver >> rating: aRating rating := aRating.
Driver >> assignedRides: aCollection assignedRides := aCollection.

"Encapsulation: assignedRides stays internal; use addRide: to modify"
Driver >> addRide: aRide
    assignedRides add: aRide.

Driver >> getDriverInfo
    ^ String streamContents: [ :s |
        s nextPutAll: 'Driver '; nextPutAll: name; nextPutAll: ' (Rating: ';
        nextPutAll: rating asString; nextPutAll: ') | Completed Rides: ';
        nextPutAll: assignedRides size asString ].


"===== Rider ====="
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    package: 'RideShare'.

Rider class >> id: anID name: aName
    ^ self new
        riderID: anID;
        name: aName;
        requestedRides: OrderedCollection new;
        yourself.

Rider >> riderID: anID  riderID := anID.
Rider >> name: aName     name := aName.
Rider >> requestedRides: aCollection requestedRides := aCollection.

Rider >> requestRide: aRide
    requestedRides add: aRide.

Rider >> viewRides
    requestedRides do: [ :r |
        Transcript show: r rideDetails; show: ' | Fare: $'; show: r fare asString; cr ].


"===== Demo / Sample Run ====="
| rides driver rider |
rides := OrderedCollection new.
rides add: (StandardRide id: 101 pickup: 'Downtown' dropoff: 'Airport' distance: 12).
rides add: (PremiumRide  id: 102 pickup: 'Mall'     dropoff: 'Hotel'   distance: 5).

driver := Driver id: 1 name: 'Aisha' rating: 4.9.
rider  := Rider  id: 10 name: 'Kashif'.

"Polymorphism: same message (fare/rideDetails) on different ride types"
Transcript show: 'Ride List (Polymorphic fare calls):'; cr.
rides do: [ :r |
    Transcript show: r rideDetails; show: ' | Fare: $'; show: r fare asString; cr ].

"Encapsulation: assign and request rides through methods"
rides do: [ :r | driver addRide: r. rider requestRide: r ].

Transcript cr; show: (driver getDriverInfo); cr.
Transcript cr; show: 'Rider Ride History:'; cr.
rider viewRides.
