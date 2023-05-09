extends Node

# The amount of time that must pass before resources are generated
const TICK_INTERVAL_SECONDS := 1.0

# Initialise the resource amounts
var primary_resources := 0.0
var secondary_resources := 0.0

var primary_resource_generation_rate := 10.0
var secondary_resource_generation_proportion := 0.1

# The amount of time that has passed since the last resource generation
var time_elapsed = 0

func _process(delta):
    # Update the time since the last generation
    time_elapsed += delta
    
    # Check if enough time has passed to generate resources
    if time_elapsed >= TICK_INTERVAL_SECONDS:
        secondary_resource_generation_rate = primary_resource_generation_rate * secondary_resource_generation_proportion
        
        # Add the generated resources to the player's total
        primary_resources += primary_resource_generation_rate
        secondary_resources += secondary_resource_generation_rate
        
        # remove one tick worth of time elapsed
        time_elapsed -= TICK_INTERVAL_SECONDS
        
        # Emit signals to notify any interested objects of the new resource amounts
        emit_signal("primary_resources_generated", generated_primary_resources)
        emit_signal("secondary_resources_generated", generated_secondary_resources)
