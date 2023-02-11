// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./access/Ownable.sol";

error OnlyOwnerOf();

contract VehiclesSwap is Ownable {
    mapping(address => Vehicle[]) private vehicleInfo;
    mapping(address => bool) private _isOwners;
    address[] private _owners;

    /****************************************************************************/
    /****************************************************************************/
    struct Vehicle {
        uint256 index;
        address ownerOf; // is wallet address of the vehicle owner
        string make;
        string model;
        string year;
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
        uint256 vehicleIndex_ = vehicleInfo[_msgSender()].length;
        _vehicle.index = vehicleIndex_;
        _vehicle.ownerOf = _msgSender();
        vehicleInfo[_msgSender()].push(_vehicle);

        if (!_isOwners[_msgSender()]) {
            _isOwners[_msgSender()] = true;
            _owners.push(_msgSender());
        }

        emit RegisterdVehicle(_msgSender(), vehicleIndex_);
    }

    /**
     * @dev updates vehicleInfo using vehicleIndex. Only callable by the owner of the vehicle.
     */
    function modifyVehicleInfo(Vehicle memory _vehicle) external {
        Vehicle memory vehicle_ = vehicleInfo[_msgSender()][_vehicle.index];
        if (vehicle_.ownerOf != _msgSender()) revert OnlyOwnerOf();
        vehicleInfo[_msgSender()][_vehicle.index] = _vehicle;
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

    /**
     * @dev returns all addresses of owners who have registerd vehicle
     */
    function owners() external view returns (address[] memory) {
        return _owners;
    }
}
