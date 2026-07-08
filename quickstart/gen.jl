# Runs the Quick start examples and writes their plots. Executed in CI so the
# figures stay in step with the packages. Env is passed with --project.
using ComposedDistributions, ComposableTuringIDModels, Distributions, CairoMakie,
    Random

const ROOT = dirname(@__DIR__)
const IMG = joinpath(ROOT, "assets", "img", "examples")
mkpath(IMG)
teal, blue, amber, red = "#0f7c8f", "#2f6f9f", "#e8965a", "#c0554e"

# --- Example 1: compose a case's delay chain across events -----------------
chain = Sequential([
    Gamma(2.0, 1.5),      # infection -> symptom onset
    LogNormal(1.0, 0.5),  # onset -> hospital admission
    Gamma(2.0, 3.0),      # admission -> death
])
show(stdout, MIME("text/plain"), chain); println()

to_onset     = Gamma(2.0, 1.5)
to_admission = convolved(to_onset, LogNormal(1.0, 0.5))
to_death     = convolved(to_admission, Gamma(2.0, 3.0))

ts = range(0, 32; length = 320)
fig1 = Figure(size = (760, 340))
ax1 = Axis(fig1[1, 1]; xlabel = "days since infection", ylabel = "density",
    title = "Delay from infection to each event")
for (d, lab, c) in [(to_onset, "onset", teal), (to_admission, "admission", blue),
                    (to_death, "death", red)]
    band!(ax1, ts, zero(ts), pdf.(d, ts); color = (c, 0.15))
    lines!(ax1, ts, pdf.(d, ts); label = lab, color = c, linewidth = 3)
end
axislegend(ax1)
save(joinpath(IMG, "composed.png"), fig1)

# --- Example 2: build a joint model and simulate ---------------------------
model = IDModel(
    DirectInfections(; Z = RandomWalk(), initialisation_prior = Normal()),
    PoissonError())
show(stdout, MIME("text/plain"), model); println()

n = 40
simulator = as_turing_model(model, missing, n)
Random.seed!(1)
sims = [simulator() for _ in 1:30]

fig2 = Figure(size = (760, 340))
ax2 = Axis(fig2[1, 1]; xlabel = "day", ylabel = "cases",
    title = "Prior predictive simulations")
for s in sims
    lines!(ax2, 1:n, s.generated_y_t; color = (blue, 0.28))
end
save(joinpath(IMG, "model.png"), fig2)
println("wrote plots to $IMG")
