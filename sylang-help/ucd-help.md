# Use Case Diagram (.ucd)

## Overview
Defines **actors and use cases** with clean flat syntax using from/to/connection relationships (NEW SYNTAX v2.21.44).

## File Structure
- **ONE** `hdef usecase` per file
- **MULTIPLE** `def actor` and `def usecase` statements
- Clean flat syntax with explicit relationships

## Valid Keywords
```
use, hdef, usecase, def, actor, usecase, name, description, owner, 
tags, level, actortype, from, to, connection, associated, includes, when, ref
```

## Actor Types
```
actortype primary    # Primary actor (initiates use cases)
actortype secondary  # Secondary actor (provides services)
```

## Connection Types
```
connection associated  # Association (actor ↔ function)
connection includes    # Inclusion (function → function)
```

## Validation Rules
- **Primary actors** must be in `from` position
- **Secondary actors** must be in `to` position
- **Functions** can be in both `from` and `to` positions
- `connection includes` only between functions
- `connection associated` between actors and functions

## Example
```sylang
use functionset ChairSystemFunctions

hdef usecase ChairSystemUseCases
  name "Height Adjustable Chair Use Cases"
  description "Use case model describing user interactions with chair system"
  owner "Systems Engineering Team"

  def actor ChairUser
    name "Chair User"
    description "Primary user who interacts with adjustment features"
    owner "User Experience Team"
    actortype primary

  def actor ChairControlSystem
    name "Chair Control System"
    description "Electronic control system managing chair functions"
    owner "Control Systems Team"
    actortype secondary

  def usecase UC_001
    name "Initiate Chair System"
    description "User initiates chair system operation"
    from ref actor ChairUser
    to ref function InitializeChairSystem
    connection associated

  def usecase UC_002
    name "Execute Pneumatic Height Adjustment"
    description "User performs height adjustment using pneumatic system"
    from ref actor ChairUser
    to ref function ExecutePneumaticHeightAdjustment
    connection associated

  def usecase UC_003
    name "Monitor Pneumatic Pressure"
    description "System monitors gas cylinder pressure during adjustment"
    from ref function ExecutePneumaticHeightAdjustment
    to ref function MonitorGasCylinderPressure
    connection includes
```

---
See `.fun` for function definitions referenced in use cases.

