
# Structure definition

struct NotationStructure
    GradeThreshold::Dict{String, <:Real}
end

function NotationStructure(threshold::AbstractVector{<:Real})
    grade = ["D","D+","C","C+","B","B+","A","A*"]
    
    @assert length(threshold)==length(grade)
    @assert issorted(threshold)
    
    d = Dict("F" => -Inf)
    
    for i in eachindex(grade)
        setindex!(d, threshold[i], grade[i],)
    end
    
    return NotationStructure(d)
end

Base.Broadcast.broadcastable(obj::NotationStructure) = Ref(obj)




# Methods for NotationStructure

function attribute_grade(NS::NotationStructure, x::Real)
    
    grade, threshold = getvalues(NS)
    
    ind = findlast(x .>= threshold )
    
    return grade[ind]
    
end

function attribute_grade(NS::NotationStructure, x::Missing)
    
    return missing
    
end

function convert(::Type{DataFrame},NS::NotationStructure)
    
    g, t = getvalues(NS)
    
    # Remove the grade F
    popfirst!(g)
    popfirst!(t)
    
    if all(isinteger.(t))
        t = Int.(t)
    end
        
    return DataFrame(Grade=g, Threshold=t)
end

function getvalues(NS::NotationStructure)
    
    threshold = collect(values(NS.GradeThreshold))
    grade = collect(keys(NS.GradeThreshold))
    ind = sortperm(threshold)

    threshold = threshold[ind]
    grade = grade[ind]
    
    return (grade, threshold)
end
    

function show(io::IO, obj::NotationStructure)
    
    grade, threshold = getvalues(obj)

    println(io, "Grade thresholds")
    for i in eachindex(threshold)
        println(io, " ", rpad(grade[i],2," "), " -> ", threshold[i])
    end

end

