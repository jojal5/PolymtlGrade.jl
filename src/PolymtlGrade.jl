module PolymtlGrade

using DataFrames, Missings
import Base: convert, show

include("notationstructure.jl")
include("utils.jl")

export
    NotationStructure,

    attribute_grade,
    convert,
    grade2num

end
