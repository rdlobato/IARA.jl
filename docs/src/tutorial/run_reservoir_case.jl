# # Virtual Reservoir - Running

# > The data for this case is available in the folder [`data/case_5`](https://github.com/psrenergy/IARA.jl/tree/master/docs/src/tutorial/data/case_5)

import Pkg #hide
Pkg.activate("../../..") #hide
Pkg.instantiate() #hide
using Dates
using DataFrames
using IARA
; #hide

# ## Case recap

# In the [previous section](build_reservoir_case.md), we have built a case containing a virtual reservoir with two hydro plants and two asset owners. Now, we will run this case in the `MARKET_CLEARING` mode.
# Now we will run this case using the `MARKET_CLEARING` mode.

# As we have Hydro Plants in this case, we need the hydro generation and hydro opportunity cost time series files. We can automatically generate them by running the case with the `CENTRALIZED_OPERATION` mode.
# We will be doing this before running the case in the `MARKET_CLEARING` mode.

# Let's create a folder to store the output of the `MARKET_CLEARING` mode and define the path to the original case.

const PATH_ORIGINAL = joinpath(@__DIR__, "data", "case_5")
const PATH_EXECUTION = joinpath(@__DIR__, "case_5_execution")

if !isdir(PATH_EXECUTION)
    mkdir(PATH_EXECUTION)
end

cp(PATH_ORIGINAL, PATH_EXECUTION; force = true);
#hide

# ## Executing

# ## Adding Hydro time series

# Let's run the case in the `CENTRALIZED_OPERATION` mode to generate the hydro generation and hydro opportunity cost time series files.
# First, we need to set the mode to `CENTRALIZED_OPERATION`.

db = IARA.load_study(PATH_EXECUTION; read_only = false);

update_configuration!(
    db;
    run_mode = Configurations_RunMode.CENTRALIZED_OPERATION,
)
; #hide

# Now we are able to run the case with [`IARA.main`](@ref).

IARA.main([PATH_EXECUTION])

# After that, we have to move the hydro generation and hydro opportunity cost time series files to the `case_5_execution` folder.

hydro_generation_file = joinpath(
    PATH_EXECUTION,
    "outputs",
    "hydro_generation.csv",
)
hydro_opportunity_cost_file = joinpath(
    PATH_EXECUTION,
    "outputs",
    "hydro_opportunity_cost.csv",
)

hydro_generation_destination =
    joinpath(PATH_EXECUTION, "hydro_generation.csv")
hydro_opportunity_cost_destination =
    joinpath(PATH_EXECUTION, "hydro_opportunity_cost.csv")

mv(hydro_generation_file, hydro_generation_destination; force = true)
mv(
    hydro_opportunity_cost_file,
    hydro_opportunity_cost_destination;
    force = true,
);
#hide

# After that, the hydro generation and hydro opportunity cost time series files will be automatically linked to our case.
# Now we are ready to run the case in the `MARKET_CLEARING` mode.

# As we need to set the run mode to `MARKET_CLEARING`, we need to open the study again.

db = IARA.load_study(PATH_EXECUTION; read_only = false);

update_configuration!(
    db;
    run_mode = Configurations_RunMode.MARKET_CLEARING,
)
; #hide

# Finally, we are ready to run the case.

IARA.main([PATH_EXECUTION])

# ### Analyzing the results

# The results are stored inside the case folder, in the `outputs` directory.

# ```
# case_folder
#  ├── outputs
#  │    ├── plots
#  │    │   └── ...
#  │    └── ...
#  └── ...
# ```

# According to our results, for the first bid segment, there is more energy generated by the first Asset Owner, which is related to their bidding prices differences.
# The second bid segment has a similar behavior, with the the first asset owner decreasing its energy generation probably due to the decrease in the hydro volume.

# ```@raw html
# <iframe src="case_5_execution\\outputs\\plots\\virtual_reservoir_generation_ex_post_commercial_all.html" style="height:500px;width:100%;"></iframe>
# ```

# Also, the volume from the first Hydro plant starts at 100 hm³, and as the energy decreases, the volume decreases as well. The second Hydro plant starts with 0 hm³ and increases over time

# ```@raw html
# <iframe src="case_5_execution\\outputs\\plots\\hydro_initial_volume_ex_post_physical_all.html" style="height:500px;width:100%;"></iframe>
# ```

# Finally, as the second hydro plant has a higher O&M cost, it is only dispatched when the energy from the first hydro plant is not enough to meet the demand.

# ```@raw html
# <iframe src="case_5_execution\\outputs\\plots\\hydro_generation_ex_post_physical_all.html" style="height:500px;width:100%;"></iframe>
# ```