# EPB External System Blocks Documentation

## Overview
This document describes the external system blocks that provide interfaces to the Electric Parking Brake (EPB) ECU. These blocks define the boundary between the EPB system and external vehicle systems.

## Sylang v2.21.24 Syntax Updates
**Important**: As of Sylang v2.21.24, the `direction` keyword is no longer valid in block (.blk) files. Message and signal definitions now use only `datatype` and `description` properties. Interface direction is determined by context and naming conventions:
- Messages/signals ending with "Output" typically provide data to other blocks
- Messages/signals ending with "Input" typically receive data from other blocks
- The EPB ECU uses input naming to indicate interfaces it needs from external systems

## Block Definition Properties

All EPB block files now include comprehensive property definitions following Sylang v2.21.24 best practices:

### **Required Properties for Blocks:**
- **name**: Human-readable block name
- **description**: Comprehensive functional description
- **designrationale**: Engineering rationale and architectural decisions
- **owner**: Responsible engineering team
- **level**: Block hierarchy level (system/subsystem/module)
- **safetylevel**: ISO 26262 safety classification (ASIL-D for EPB)
- **tags**: Searchable classification tags
- **enables**: Features enabled by this block

### **Required Properties for Messages/Signals:**
- **name**: Human-readable interface name
- **description**: Detailed functional description
- **designrationale**: Engineering justification for interface design
- **owner**: Responsible team for interface definition
- **datatype**: Data structure type
- **safetylevel**: Safety classification (ASIL-D for safety-critical interfaces)
- **tags**: Searchable classification and functional tags

### **Enhanced Documentation Features:**
- Detailed design rationales explaining architectural decisions
- Clear ownership assignments for maintenance responsibility
- Comprehensive tagging for project searchability
- Safety level classifications for ISO 26262 compliance
- Structured comments for better code understanding

### 1. VehicleSystemsInterface (EPB_ExternalSystems.blk)
**Purpose**: Represents external vehicle systems that provide input data to the EPB ECU.

**Key Interfaces**:
- **VehicleStateOutput** → **VehicleStateInput** (EPB ECU)
- **DriverCommandOutput** → **DriverCommandInput** (EPB ECU)  
- **ActuatorFeedbackOutput** → **ActuatorFeedback** (EPB ECU)
- **VehicleSpeedOutput** → **VehicleSpeed** (EPB ECU)
- **SlopeAngleOutput** → **SlopeAngle** (EPB ECU)
- **IgnitionStateOutput** → **IgnitionState** (EPB ECU)
- **TransmissionStateOutput** → **TransmissionState** (EPB ECU)
- **ActuatorPositionOutput** → **ActuatorPosition** (EPB ECU)
- **ActuatorCurrentOutput** → **ActuatorCurrent** (EPB ECU)

**Source Systems**:
- ABS/ESP system (vehicle speed)
- Inclinometer/accelerometer (slope angle)
- Body control module (ignition state)
- Transmission control module (gear position)
- Brake actuator hardware (position, current, temperature)

### 2. DriverInterfaceSystem (EPB_DriverInterface.blk)
**Purpose**: Represents the human-machine interface components for EPB operation.

**Key Interfaces**:
- **DriverEPBCommandOutput** → **DriverCommandInput** (EPB ECU)
- **EPBSwitchPosition** → Driver command processing
- **EPB_StatusInput** ← **EPB_StatusReport** (from EPB ECU)
- **EPB_DiagnosticInput** ← **EPB_DiagnosticData** (from EPB ECU)
- **EPBIndicatorControl** ← EPB status indicators
- **EPBWarningBuzzer** ← EPB audible alerts

**HMI Components**:
- EPB control switch (engage/disengage/auto)
- Dashboard warning lights
- Status indicators
- Warning buzzer system

### 3. VehicleNetworkInterface (EPB_VehicleNetwork.blk)
**Purpose**: Represents the vehicle communication network and diagnostic interfaces.

**Key Interfaces**:
- **EPB_CANStatusOutput** ← **EPB_StatusReport** (from EPB ECU)
- **EPB_CANDiagnosticOutput** ← **EPB_DiagnosticData** (from EPB ECU)
- **VehicleCANInput** → Vehicle network data processing
- **CANBusActivity** → Network health monitoring
- **DiagnosticRequest** → OBD/service tool requests
- **NetworkFaultStatus** → Communication fault detection

**Network Components**:
- CAN bus infrastructure
- OBD diagnostic port
- Service tool interfaces
- Network gateway modules

## Interface Relationships

### Input Flow to EPB ECU:
```
VehicleSystemsInterface → EPB ECU (vehicle data, actuator feedback)
DriverInterfaceSystem → EPB ECU (driver commands)
VehicleNetworkInterface → EPB ECU (network requests, vehicle CAN data)
```

### Output Flow from EPB ECU:
```
EPB ECU → DriverInterfaceSystem (status, diagnostics for driver display)
EPB ECU → VehicleNetworkInterface (CAN broadcast, diagnostic data)
```

## Safety Considerations

All external system blocks maintain **ASIL-D** safety classification to ensure:
- Safety-critical data integrity
- Fault detection and isolation
- Redundant sensor feedback
- Diagnostic coverage for external interfaces

## Implementation Notes

1. **Message Mapping**: Each output message/signal from external systems maps to corresponding input message/signal in EPB ECU
2. **Data Types**: Consistent data type definitions across interface boundaries
3. **Safety Compliance**: All interfaces comply with ISO 26262 ASIL-D requirements
4. **Traceability**: Clear traceability from feature model to block interfaces

## Future Enhancements

- Add redundant sensor interfaces for enhanced fault tolerance
- Implement secure communication protocols for cyber security
- Add over-the-air update interfaces for software maintenance
- Extend diagnostic capabilities for predictive maintenance
