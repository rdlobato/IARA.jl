#  Copyright (c) 2024: PSR, CCEE (Câmara de Comercialização de Energia  
#      Elétrica), and contributors
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#############################################################################
# IARA
# See https://github.com/psrenergy/IARA.jl
#############################################################################

function virtual_reservoir_volume_balance! end

function virtual_reservoir_volume_balance!(
    model::SubproblemModel,
    inputs::Inputs,
    run_time_options::RunTimeOptions,
    ::Type{SubproblemBuild},
)
    virtual_reservoirs = index_of_elements(inputs, VirtualReservoir)
    number_of_segments = maximum_number_of_virtual_reservoir_bidding_segments(inputs)

    # Model variables
    virtual_reservoir_generation = get_model_object(model, :virtual_reservoir_generation)
    hydro_turbining = get_model_object(model, :hydro_turbining)
    hydro_spillage = get_model_object(model, :hydro_spillage)

    # Model constraints
    @constraint(
        model.jump_model,
        virtual_reservoir_generation_balance[vr in virtual_reservoirs],
        sum(
            (hydro_turbining[b, h] + hydro_spillage[b, h]) * hydro_plant_production_factor(inputs, h) /
            m3_per_second_to_hm3_per_hour()
            for b in blocks(inputs), h in virtual_reservoir_hydro_plant_indices(inputs, vr)
        ) == sum(
            virtual_reservoir_generation[vr, ao, seg] for ao in virtual_reservoir_asset_owner_indices(inputs, vr),
            seg in 1:number_of_segments
        )
    )

    return nothing
end

function virtual_reservoir_volume_balance!(
    model::SubproblemModel,
    inputs::Inputs,
    run_time_options::RunTimeOptions,
    scenario::Int,
    subscenario::Int,
    ::Type{SubproblemUpdate},
)
    return nothing
end

function virtual_reservoir_volume_balance!(
    outputs::Outputs,
    inputs::Inputs,
    run_time_options::RunTimeOptions,
    ::Type{InitializeOutput},
)
    return nothing
end

function virtual_reservoir_volume_balance!(
    outputs::Outputs,
    inputs::Inputs,
    run_time_options::RunTimeOptions,
    simulation_results::SimulationResultsFromStageScenario,
    stage::Int,
    scenario::Int,
    subscenario::Int,
    ::Type{WriteOutput},
)
    return nothing
end