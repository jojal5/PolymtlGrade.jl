

@testset "NotationStructure constructor" begin
    @testset "Threshold entry" begin
    
        threshold = [55, 60, 65, 70, 75, 80, 85, 95]
        grade = ["D","D+","C","C+","B","B+","A","A*"]

        NS = NotationStructure(threshold)

        NS.GradeThreshold

        @test NS.GradeThreshold["F"] ≈ -Inf

        for i in eachindex(threshold)
           @test NS.GradeThreshold[grade[i]] ≈ threshold[i]
        end
        
        @test_throws AssertionError NotationStructure(threshold[2:end])
        @test_throws AssertionError NotationStructure(threshold[end:-1:1])
        
    end

    @testset "Dictionary entry" begin
       
        threshold = [55, 60, 65, 70, 75, 80, 85, 95]
        grade = ["D","D+","C","C+","B","B+","A","A*"]

        r = NotationStructure(threshold)
        
        NS = NotationStructure(r.GradeThreshold)
        
        @test r.GradeThreshold == NS.GradeThreshold
        
    end

    @testset "Broadcast" begin

        threshold = [55, 60, 65, 70, 75, 80, 85, 95]

        r = NotationStructure.([threshold, threshold])

        NS = NotationStructure(threshold)

        @test r[1].GradeThreshold == NS.GradeThreshold
        @test r[2].GradeThreshold == NS.GradeThreshold

    end
end

    @testset "attribute_grade" begin
   
        threshold = [55, 60, 65, 70, 75, 80, 85, 95]
        
        NS = NotationStructure(threshold)
        
        @test attribute_grade(NS, 40) == "F"
        @test attribute_grade(NS, 55) == "D"
        @test attribute_grade(NS, 71) == "C+"
        @test attribute_grade(NS, 70) == "C+"
        @test attribute_grade(NS, 200) == "A*"
        
        @test ismissing(attribute_grade(NS, missing))
    end
    
@testset "convert" begin
    
    grade = ["D","D+","C","C+","B","B+","A","A*"]
    threshold = [55, 60, 65, 70, 75, 80, 85, 95]
        
    NS = NotationStructure(threshold)

    df = DataFrame(Grade = grade, Threshold=threshold)

    @test isequal(convert(DataFrame, NS), df)

end

@testset "getvalues" begin

    threshold = [55, 60, 65, 70, 75, 80, 85, 95]
    grade = ["D","D+","C","C+","B","B+","A","A*"]

    NS = NotationStructure(threshold)

    k,v = PolymtlGrade.getvalues(NS)
    
    @test k[1] == "F"
    @test v[1] == -Inf
    
    @test all(k[2:end] .== grade)
    @test all(v[2:end] .== threshold)
    
end

@testset "Base.show(io, obj::NotationStructure)" begin
    threshold = [55, 60, 65, 70, 75, 80, 85, 95]
    NS = NotationStructure(threshold)
    buffer = IOBuffer()
    @test_logs Base.show(buffer, NS)
end