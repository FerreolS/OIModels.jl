Optimisers.trainable(x::Interpolate) = (; values = x.values)

import ChainRulesCore: ProjectTo, _eltype_projectto
(project::ProjectTo{AxisArray})(dx::AbstractArray) = AxisArray(dx, project.axes)
function ChainRulesCore.ProjectTo(xs::AxisArray{T}) where {T <: AbstractArray}

    elements = map(ProjectTo, xs)
    if elements isa AbstractArray{<:ProjectTo{<:AbstractZero}}
        return ProjectTo{NoTangent}()  # short-circuit if all elements project to zero
    else
        # Arrays of arrays come here, and will apply projectors individually:
        return ProjectTo{AxisArray}(; elements = elements, axes = AxisArrays.axes(xs))
    end
end

# For arrays of numbers, just store one projector:
function ProjectTo(x::AxisArray{T}) where {T <: Number}
    return ProjectTo{AxisArray}(; element = _eltype_projectto(T), axes = AxisArrays.axes(x))
end
