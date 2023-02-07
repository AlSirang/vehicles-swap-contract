// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./access/Ownable.sol";
import "./utils/Counters.sol";

error OnlyOwnerOf();

contract VehiclesSwap is Ownable {
    using Counters for Counters.Counter;

    /****************************************************************************/
    /****************************************************************************/
    Counters.Counter private vehicleIndexes;
    mapping(address => Vehicle[]) private vehicleInfo;

    /****************************************************************************/
    /****************************************************************************/
    struct Vehicle {
        uint256 index;
        address ownerOf; // is wallet address of the vehicle owner
        string make;
        string model;
        string year; // Unix timestamp.
        string value; // amount of value in $
        string VIN;
        string verifiedOwner;
        string mileage;
        string exteriorColor;
        string interiorColor;
        string arrisCode;
        string roofLoad;
        string accelerationTime;
        string bodyType;
        string firstRegisteredDate;
        string driveWheelConfiguration;
        string seatingCapacity;
        string steeringPosition;
        string carLocation;
        string knownDamage;
    }

    /****************************************************************************/
    /****************************************************************************/
    event RegisterdVehicle(address indexed owner, uint256 indexed vehicleIndex);

    event RemovedVehicle(address indexed owner, uint256 indexed vehicleIndex);

    /**
     * @dev adds vehicle to vehicleInfo mapping and updates owner index.
     */
    function registerVehicle(Vehicle memory _vehicle) external {
        vehicleIndexes.increment(); // start counter at 1
        uint256 vehicleIndex_ = vehicleIndexes.current();
        _vehicle.index = vehicleIndex_;
        _vehicle.ownerOf = _msgSender();
        vehicleInfo[_msgSender()].push(_vehicle);

        emit RegisterdVehicle(_msgSender(), vehicleIndex_);
    }

    /**
     * @dev updates vehicleInfo using vehicleIndex. Only callable by the owner of the vehicle.
     */
    function modifyVehicleInfo(Vehicle memory _vehicle) external {
        Vehicle memory vehicle_ = vehicleInfo[_msgSender()][_vehicle.index];
        if (vehicle_.ownerOf != _msgSender()) revert OnlyOwnerOf();
        vehicleInfo[_msgSender()][_vehicle.index] = vehicle_;
    }

    /**
     * @dev delete vehicleInfo using vehicleIndex. Only callable by the owner of the vehicle.
     */
    function removeVehicleInfo(uint256 vehicleIndex) external {
        Vehicle memory vehicle_ = vehicleInfo[_msgSender()][vehicleIndex];

        if (vehicle_.ownerOf != _msgSender()) revert OnlyOwnerOf();

        delete vehicleInfo[_msgSender()][vehicleIndex];

        emit RegisterdVehicle(_msgSender(), vehicleIndex);
    }

    /****************************************************************************/
    /****************************************************************************/

    /**
     * @dev returns all vehicles information added and owned by the owner
     */
    function vehiclesOf(address _owner)
        external
        view
        returns (Vehicle[] memory)
    {
        return vehicleInfo[_owner];
    }
}
