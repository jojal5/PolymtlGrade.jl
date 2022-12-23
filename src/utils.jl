
function grade2num(g::AbstractString)
    grade = ["F","D","D+","C","C+","B","B+","A","A*"]
    
    @assert g ∈ grade "the grade $g does not exist in the notation structure."
    
    num = collect(1:.5:4)
    pushfirst!(num,0)
    push!(num,4)
    
    ind = findfirst(grade .== g)
    
    return num[ind]
    
end