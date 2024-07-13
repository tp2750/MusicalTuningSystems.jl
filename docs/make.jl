using MusicalTuningSystems
using Documenter

DocMeta.setdocmeta!(
    MusicalTuningSystems,
    :DocTestSetup,
    :(using MusicalTuningSystems);
    recursive = true,
)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers

function nice_name(file)
    file = replace(file, r"^[0-9]*-" => "")
    if haskey(page_rename, file)
        return page_rename[file]
    end
    return splitext(file)[1] |> x -> replace(x, "-" => " ") |> titlecase
end

makedocs(;
    modules = [MusicalTuningSystems],
    doctest = true,
    linkcheck = false, # Rely on Lint.yml/lychee for the links
    authors = "Thomas Agersten Poulsen <ta.poulsen@gmail.com> and contributors",
    repo = "https://github.com/tp2750/MusicalTuningSystems.jl/blob/{commit}{path}#{line}",
    sitename = "MusicalTuningSystems.jl",
    format = Documenter.HTML(;
        prettyurls = true,
        canonical = "https://tp2750.github.io/MusicalTuningSystems.jl",
        assets = ["assets/style.css"],
    ),
    pages = [
        "Home" => "index.md"
        [
            nice_name(file) => file for file in readdir(joinpath(@__DIR__, "src")) if
            file != "index.md" && splitext(file)[2] == ".md"
        ]
    ],
)

deploydocs(; repo = "github.com/tp2750/MusicalTuningSystems.jl", push_preview = true)
