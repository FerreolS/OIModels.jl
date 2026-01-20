module OIModels

import UnitfulAngles: mas

using AxisArrays
using ConcreteStructs
using Interpolations
using LinearInterpolations
using Optimisers
using Unitful,
    ChainRulesCore

include("types.jl")
include("models.jl")
include("piracy.jl")
end
