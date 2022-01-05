using Pkg

function main()
    if length(ARGS) != 1
        println("Usage: $PROGRAM_FILE <package name>")
        exit()
    end
    tgt = ARGS[1]
    println("Checking packages which requires $(tgt)...")
    pkgs = search(tgt)
    println("$(length(pkgs)) packages found.")
    for ipkg in pkgs
        println(" - $(ipkg)")
    end
end

function search(tgt)
    cont = Array{String, 1}()
    deps = Pkg.dependencies()
    for (key, value) in deps
        name  = value.name
        ideps = value.dependencies
        tgt in keys(ideps) && push!(cont, name)
    end
    return cont
end

main()
