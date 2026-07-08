# Install the packages the Quick start figures need, latest from GitHub so the
# figures stay current. Run with --project=quickstart before gen.jl.
using Pkg
Pkg.add([
    PackageSpec(url = "https://github.com/EpiAware/ConvolvedDistributions.jl"),
    PackageSpec(url = "https://github.com/EpiAware/ComposedDistributions.jl"),
    PackageSpec(url = "https://github.com/EpiAware/ModifiedDistributions.jl"),
    PackageSpec(url = "https://github.com/EpiAware/ComposableTuringIDModels.jl"),
    PackageSpec(name = "Distributions"),
    PackageSpec(name = "CairoMakie"),
])
Pkg.precompile()
