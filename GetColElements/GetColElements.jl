function GetColElements(T::Type, buff::String, cols::Vararg{Int}; cmt="#")::Array{Array{T, 1}, 1}
    ncols  = length(cols)
    colmin = minimum(cols)
    colmax = maximum(cols)
    cont = Array{Array{T, 1}, 1}()
    for iline in split(buff, "\n")
        words = split(split(iline, cmt)[1])
        if length(words) < colmin
            continue
        end
        elem  = Array{T, 1}()
        for (i, iword) in enumerate(words)
            if colmax < i
                break
            end
            if i in cols
                if T <: Number
                    try
                        push!(elem, parse(T, iword))
                    catch
                        push!(elem, nothing)
                    end
                elseif T == String
                    push!(elem, iword)
                else
                    push!(elem, nothing)
                end
            end
        end
        if 0 < length(elem) <= ncols
            push!(cont, elem)
        end
    end
    return cont
end
