---
**📚 Sylang Help Documentation | Version 2.34.38**
---

# Variant Model (.vml)

## Overview
The `.vml` file defines **variant selections** from a feature model. It is **AUTO-GENERATED** from `.fml` files and should never be created manually.

## ⚠️ IMPORTANT: AUTO-GENERATED FILE
**DO NOT CREATE MANUALLY!**  
Use the command: **Right-click `.fml` file → "Generate VML from FML"**

## File Structure Rules
- **ONE** `hdef variantset` statement per file
- **MULTIPLE** `.vml` files per folder allowed
- **NO** `def` statements - only `extends ref feature` relations
- Must `use featureset` at the top
- Auto-generated with selection states

## Valid Keywords
```
use, hdef, variantset, name, description, owner, tags, 
extends, ref, feature, mandatory, optional, or, alternative, selected
```

## Syntax Structure
```
use featureset [featureset-ref]

hdef variantset [identifier]
  name [string-literal]
  description [string-literal]
  owner [string-literal]
  tags [string-literal], [string-literal], ...

  extends ref feature [feature-ref] [mandatory|optional|or|alternative] [selected]
    extends ref feature [sub-feature] [mandatory|optional|or|alternative] [selected]
      # Hierarchical extension structure mirrors .fml
      
### Selection States:
 - Add 'selected' keyword to include feature in variant
 - Omit 'selected' to exclude feature from variant

### Constraint Rules:
 - mandatory features: MUST be selected
 - optional features: MAY be selected
 - or features: AT LEAST ONE sibling must be selected
 - alternative features: EXACTLY ONE sibling must be selected
```


## Complete Example

```sylang
use featureset AutonomousVehicleFeatures

hdef variantset AutonomousVehicleVariants_Premium
  name "Premium Autonomous Vehicle Configuration"
  description """
    Premium variant with full sensor suite including LiDAR and 
    advanced HMI features for luxury autonomous vehicles.
    """
  owner "Product Line Engineering"
  tags "variants", "premium", "full-sensor", "L3-automation"

  extends ref feature CoreAutonomousFeatures mandatory selected
    extends ref feature PerceptionSystem mandatory selected
      extends ref feature CameraSystem mandatory selected
      extends ref feature LidarSystem optional selected
      extends ref feature RadarSystem mandatory selected
    extends ref feature PlanningSystem mandatory selected  
      extends ref feature GlobalPlanning mandatory selected
      extends ref feature LocalPlanning mandatory selected
    extends ref feature ControlSystem mandatory selected
      extends ref feature SteeringControl mandatory selected
      extends ref feature BrakeControl mandatory selected
      extends ref feature ThrottleControl mandatory selected
      
  extends ref feature SafetyMonitoring mandatory selected
    extends ref feature SystemHealthMonitoring mandatory selected
    extends ref feature FallbackSystem mandatory selected
    extends ref feature RedundantSensors optional selected
    
  extends ref feature HumanMachineInterface optional selected
    extends ref feature TakeoverRequest or selected
    extends ref feature StatusDisplay or
    extends ref feature VoiceInterface or
```

## Variant Examples

### Basic Variant (Minimal Configuration)
```sylang
use featureset AutonomousVehicleFeatures

hdef variantset AutonomousVehicleVariants_Basic
  name "Basic Autonomous Vehicle Configuration"
  description "Entry-level autonomous configuration with essential sensors"
  owner "Product Engineering"
  tags "basic", "entry-level", "cost-optimized"

  extends ref feature CoreAutonomousFeatures mandatory selected
    extends ref feature PerceptionSystem mandatory selected
      extends ref feature CameraSystem mandatory selected
      extends ref feature LidarSystem optional  # NOT selected
      extends ref feature RadarSystem mandatory selected
```

### Sport Variant
```sylang
use featureset VehicleFeatures

hdef variantset SportVariant
  name "Sport Performance Variant"
  description "Performance-oriented configuration"
  
  extends ref feature PowertrainType mandatory selected
    extends ref feature ElectricPowertrain alternative selected
    extends ref feature HybridPowertrain alternative  # NOT selected
    
  extends ref feature PerformanceFeatures optional selected
    extends ref feature SportSuspension optional selected
    extends ref feature PerformanceBrakes optional selected
```

## Selection Constraint Rules

### Mandatory Features
```sylang
extends ref feature CoreSafety mandatory selected
# Mandatory features MUST be selected
```

### Optional Features
```sylang
extends ref feature LuxuryPackage optional selected     # Can be selected
extends ref feature TrailerPackage optional             # Can be omitted
```

### OR Features (At Least One)
```sylang
extends ref feature DisplayOptions optional selected
  extends ref feature Display7Inch or selected          # Selected
  extends ref feature Display10Inch or                  # Not selected
  extends ref feature Display12Inch or                  # Not selected
# At least one OR sibling must be selected
```

### Alternative Features (Exactly One)
```sylang
extends ref feature TransmissionType mandatory selected
  extends ref feature ManualTransmission alternative    # Not selected
  extends ref feature AutomaticTransmission alternative selected
  extends ref feature CVTTransmission alternative       # Not selected
# Exactly one ALTERNATIVE sibling must be selected
```

## Validation Rules
✅ Must be generated from `.fml` file  
✅ Exactly one `hdef variantset` per file  
✅ Multiple `.vml` files allowed per folder  
✅ Must include `use featureset` statement  
✅ Must use `extends ref feature` pattern  
✅ Must respect mandatory/optional/or/alternative constraints  
✅ OR features: At least one sibling must be `selected`  
✅ ALTERNATIVE features: Exactly one sibling must be `selected`  
❌ DO NOT create manually - use "Generate VML from FML" command  
❌ Cannot use `when ref config` (not allowed in .vml)  
❌ No `def` statements allowed

## Generation Workflow

### Step 1: Create Feature Model
```sylang
# ProductFeatures.fml
use productline MyProductLine

hdef featureset ProductFeatures
  def feature CoreFeatures mandatory
    def feature Feature1 mandatory
    def feature Feature2 optional
```

### Step 2: Generate VML
**Right-click `ProductFeatures.fml` → "Generate VML from FML"**

Result:
```sylang
# ProductFeatures.vml (auto-generated)
use featureset ProductFeatures

hdef variantset ProductFeaturesVariants
  extends ref feature CoreFeatures mandatory selected
    extends ref feature Feature1 mandatory selected
    extends ref feature Feature2 optional selected
```

### Step 3: Customize Selections
Edit the `.vml` file to create your specific variant by adding/removing `selected`:
```sylang
extends ref feature Feature2 optional  # Remove 'selected' to exclude
```

### Step 4: Generate Configuration
**Right-click `.vml` → "Generate VCF from VML"** to create configuration file

## File Organization
```
ProductLine/
├── Features/
│   ├── ProductFeatures.fml           # Source feature model
│   ├── ProductFeatures_Premium.vml   # Premium variant
│   ├── ProductFeatures_Basic.vml     # Basic variant
│   └── ProductFeatures_Sport.vml     # Sport variant
```

## Common Patterns

### Regional Variants
```sylang
# EuropeVariant.vml
hdef variantset EuropeVariant
  extends ref feature EuropeanCompliance mandatory selected
  extends ref feature GDPRFeatures mandatory selected
  
# NorthAmericaVariant.vml  
hdef variantset NorthAmericaVariant
  extends ref feature FMVSSCompliance mandatory selected
  extends ref feature SAEStandards mandatory selected
```

### Market Segment Variants
```sylang
# LuxuryVariant.vml
hdef variantset LuxuryVariant
  extends ref feature PremiumFeatures optional selected
  extends ref feature AdvancedSafety optional selected
  
# EconomyVariant.vml
hdef variantset EconomyVariant
  extends ref feature BasicFeatures mandatory selected
  extends ref feature PremiumFeatures optional  # NOT selected
```

## Error Prevention

### ❌ DO NOT DO THIS
```sylang
# WRONG - Creating .vml manually
hdef variantset MyVariant
  def feature SomeFeature  # ❌ No def statements!
```

### ✅ CORRECT APPROACH
1. Create `.fml` file with features
2. Right-click `.fml` → "Generate VML from FML"
3. Edit generated `.vml` to adjust selections
4. Right-click `.vml` → "Generate VCF from VML"

---

**Next Steps**: After generating and customizing your `.vml` file, generate the `.vcf` configuration file.

