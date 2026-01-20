abstract type OIModel end

Base.@kwdef struct OIDataPoint{U, V, L, P, T}
    u::U
    v::V
    λ::L = nothing
    p::P = nothing
    t::T = nothing
end

(a::AbstractVector{T})(d::OIDataPoint) where {T <: Number} = a
