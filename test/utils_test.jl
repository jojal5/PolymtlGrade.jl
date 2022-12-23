@testset "grade2num(g::AbstractString)" begin
   
    grade = ["F","D","D+","C","C+","B","B+","A","A*"]
    num = collect(1:.5:4)
    pushfirst!(num,0)
    push!(num,4)
    
    for i in eachindex(grade)
        @test grade2num(grade[i]) ≈ num[i]
    end
    
    @test_throws AssertionError grade2num("A+")

    @test ismissing(grade2num(missing))
    
end