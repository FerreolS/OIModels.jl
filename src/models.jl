struct Punct{P, F} <: OIModel
    position::P
    flux::F
end

function ((; position, flux)::Punct)(d::OIDataPoint)
    x, y = position(d)
    flux = get_flux(flux, d)
    (; u, v) = d
    return flux * cis(2π * (u * x .+ v * y))
end

function (A::NTuple{N, OIModel})(d::OIDataPoint) where {N}
    return mapreduce(x -> x(d), +, A; init = zero(ComplexF64))
end

get_flux((; flux)::OIModel, d::OIDataPoint) = get_flux(flux, d)
get_flux(flux::F, ::OIDataPoint) where {F <: Number} = flux
get_flux(flux::AbstractArray{T}, (; λ)::OIDataPoint{U, V, T2, Nothing, Nothing}) where {U, V, T <: Number, T2 <: Number} = length(flux) == 1 ? flux[1] : flux[λ]
# get_flux(flux::F, (; λ)::OIDataPoint{U, V, L, Nothing, Nothing}) where {U, V, L, F <: AbstractInterpolation} = flux(λ)
get_flux(flux::Interpolate, (; λ)::OIDataPoint{U, V, L, Nothing, Nothing}) where {U, V, L} = flux(λ)


