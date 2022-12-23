using PolymtlGrade
using Test
using DataFrames, Missings

@testset "PolymtlGrade.jl" begin
    include("notationstructure_test.jl")
    include("utils_test.jl")
end
