#  Copyright (c) 2024: PSR, CCEE (Câmara de Comercialização de Energia  
#      Elétrica), and contributors
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#############################################################################
# IARA
# See https://github.com/psrenergy/IARA.jl
#############################################################################

module TestCase05IncrementalInflowCase

using Test
using IARA

const PATH = @__DIR__

include("../base_case/build_base_case.jl")
include("build_incremental_inflow_case.jl")

IARA.main([PATH])

if Main.UPDATE_RESULTS
    Main.update_outputs!(PATH)
else
    Main.compare_outputs(PATH;
        test_only_block_sum = [
            "attended_demand",
            "dc_flow",
            "deficit",
            "hydro_generation",
            "hydro_turbining",
            "thermal_generation",
        ],
        test_only_first_block = ["hydro_initial_volume"],
    )
end

end