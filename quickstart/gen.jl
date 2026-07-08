# Runs the Quick start examples in CI so the page stays in step with the
# packages: the composed tree and its properties are exercised (a break shows
# up as a failed build), and the model figure is regenerated. Env is passed
# with --project.
using ComposedDistributions, ModifiedDistributions, ComposableTuringIDModels,
    Distributions, CairoMakie, Random

const ROOT = dirname(@__DIR__)
const IMG = joinpath(ROOT, "assets", "img", "examples")
mkpath(IMG)

# --- Example 1: a fancy composed tree, shown through its own properties ----
tree = Sequential([
    Gamma(2.0, 1.5),                                     # infection → onset
    compose((admission = affine(LogNormal(1.0, 0.5); scale = 1.5),
             death     = Gamma(2.0, 3.0))),              # onset → outcome
])
show(stdout, MIME("text/plain"), tree); println()
show(stdout, MIME("text/plain"), params_table(tree)); println()
println(rand(Xoshiro(1), tree))

# --- Example 2: build a joint model, show it, simulate, and plot -----------
model = IDModel(
    DirectInfections(; Z = RandomWalk(), initialisation_prior = Normal()),
    PoissonError())
show(stdout, MIME("text/plain"), model); println()

n = 40
simulator = as_turing_model(model, missing, n)
Random.seed!(1)
sims = [simulator() for _ in 1:30]

fig = Figure(size = (760, 340))
ax = Axis(fig[1, 1]; xlabel = "day", ylabel = "cases",
    title = "Prior predictive simulations")
for s in sims
    lines!(ax, 1:n, s.generated_y_t; color = ("#2f6f9f", 0.28))
end
save(joinpath(IMG, "model.png"), fig)
println("wrote model plot")
